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

require 'fileutils'
require 'rubygems/package'
require 'zlib'

transform = proc do |hk, hv|
  hv.is_a?(Array) ? hv.map { |v| "#{hk} #{v}" } : "#{hk} #{hv}".strip
end

pki_dir = node[cookbook_name]['pki_dir']
data_bag_name = node[cookbook_name]['data_bag']

return if data_bag_name.nil?

create_tarball = lambda do |tarball, files, config|
  File.open(tarball, 'wb') do |t|
    Zlib::GzipWriter.wrap(t) do |gz|
      Gem::Package::TarWriter.new(gz) do |tar|
        content = "#{config.join("\n")}\n"
        tar.add_file_simple('client.ovpn', 0o644, content.length) do |io|
          io.write(content)
        end
        files.each do |file|
          mode = File.stat(file).mode
          File.open(file, 'rb') do |f|
            tar.add_file_simple(File.basename(file), mode, f.size) do |io|
              io.write(f.read)
            end
          end
        end
      end
    end
  end
end

env = node[cookbook_name]['easy_rsa']['vars'].transform_values(&:to_s)
easy_rsa_bin = "#{node[cookbook_name]['easy_rsa']['dir']}/easyrsa"

# Generate client configuration for each user found in data bag
# rubocop:disable Metrics/BlockLength
data_bag(data_bag_name).each do |item|
  client = data_bag_item(data_bag_name, item)
  next unless client['vpn']

  id = client['id']
  tarball = "/home/#{client['id']}/#{node[cookbook_name]['tarball']}"

  files = {
    'ca' => node[cookbook_name]['server_config']['ca'],
    'cert' => "#{pki_dir}/issued/#{client['id']}.crt",
    'key' => "#{pki_dir}/private/#{client['id']}.key"
  }

  common = node[cookbook_name]['config'].map(&transform)
  client_config = node[cookbook_name]['client_config'].to_h

  files.each { |type, path| client_config[type] = File.basename(path) }

  config = client_config.map(&transform)
  content = common.concat(config).flatten.sort

  # Generate client certificate and key
  exec = {
    "generate #{id} signing request and key" => {
      'command' => "#{easy_rsa_bin} --req-cn=#{id} gen-req #{id} nopass",
      'creates' => files['key']
    },
    "sign #{id} certificate request" => {
      'command' => "#{easy_rsa_bin} sign-req client #{id}",
      'creates' => files['cert']
    }
  }

  exec.each_pair do |desc, conf|
    execute desc do
      environment(env)
      command conf['command']
      creates conf['creates']
    end
  end

  # Add PSK file if needed
  psk = node[cookbook_name]['config'].dig('tls-auth')
  files['ta'] = "#{node[cookbook_name]['config_dir']}/#{psk}" unless psk.nil?

  # Deploy tarball in user's home
  ruby_block "create #{id} openvpn configuration tarball" do
    block { create_tarball.call(tarball, files.values, content) }
    action :run
    not_if { File.exist?(tarball) }
  end
end
# rubocop:enable Metrics/BlockLength
