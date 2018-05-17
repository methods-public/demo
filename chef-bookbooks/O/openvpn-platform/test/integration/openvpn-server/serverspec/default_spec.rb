#
# Copyright (c) 2017-2018 Make.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

server_config = <<-SERVER_CONFIG.gsub(/^ */, '')
  ca /etc/openvpn/server/pki/ca.crt
  cert /etc/openvpn/server/pki/issued/server.crt
  cipher AES-256-CBC
  compress lz4-v2
  dev tun
  dh /etc/openvpn/server/pki/dh.pem
  explicit-exit-notify 1
  ifconfig-pool-persist ipp.txt
  keepalive 10 120
  key /etc/openvpn/server/pki/private/server.key
  persist-key
  persist-tun
  port 1194
  proto udp
  push "compress lz4-v2"
  push "dhcp-option DNS 8.8.8.8"
  server 10.8.0.0 255.255.255.0
  status openvpn-status.log
  tls-auth ta.key
  verb 3
SERVER_CONFIG

describe file('/etc/openvpn/server/server.conf') do
  it { should contain(server_config) }
end

describe service('openvpn-server@server') do
  it { should be_enabled }
  it { should be_running.under('systemd') }
end

client_config = <<-CLIENT_CONFIG.gsub(/^ */, '')
  ca ca.crt
  cipher AES-256-CBC
  dev tun
  compress lz4-v2
  mute-replay-warnings
  nobind
  persist-key
  persist-tun
  proto udp
  remote my-server-1 1194
  remote-cert-tls server
  resolv-retry infinite
  tls-auth ta.key
  verb 3
CLIENT_CONFIG

# rubocop:disable Metrics/BlockLength
%w[user1 user2].each do |user|
  File.open("/home/#{user}/openvpn.tar.gz", 'rb') do |file|
    Zlib::GzipReader.wrap(file) do |gz|
      Gem::Package::TarReader.new(gz) do |tar|
        tar.each do |entry|
          file = File.join("/home/#{user}/", entry.full_name)
          File.open(file, 'wb') do |f|
            f.write entry.read
          end
        end
      end
    end
  end

  describe file("/home/#{user}/client.ovpn") do
    it { should contain(client_config) }
    it { should contain("cert #{user}.crt") }
    it { should contain("key #{user}.key") }
  end

  pki_dir = '/etc/openvpn/server/pki'
  files = {
    "#{pki_dir}/ca.crt" => "/home/#{user}/ca.crt",
    "#{pki_dir}/issued/#{user}.crt" => "/home/#{user}/#{user}.crt",
    "#{pki_dir}/private/#{user}.key" => "/home/#{user}/#{user}.key"
  }

  files.each do |origin, copy|
    digest = Digest::MD5.hexdigest(File.read(origin))
    describe file(copy) do
      its(:md5sum) { should eq digest }
    end
  end
end
# rubocop:enable Metrics/BlockLength
