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

type = node[cookbook_name]['type']

if type == 'server'

  # Create OpenVPN PKI directory
  pki_dir = node[cookbook_name]['pki_dir']
  [
    pki_dir,
    "#{pki_dir}/private",
    "#{pki_dir}/reqs"
  ].uniq.each do |dir|
    directory dir do
      owner 'root'
      group 'root'
      recursive true
      mode '0700'
    end
  end

  # Generate OpenVPN PKI
  easy_rsa_bin = "#{node[cookbook_name]['easy_rsa']['dir']}/easyrsa"
  env = node[cookbook_name]['easy_rsa']['vars'].transform_values(&:to_s)

  exec = {
    'generate master CA certificate and key' => {
      'command' => "#{easy_rsa_bin} --req-cn='Easy-RSA CA' build-ca nopass",
      'creates' => "#{pki_dir}/private/ca.key"
    },
    'generate server certificate signing request and key' => {
      'command' =>
        "#{easy_rsa_bin} --req-cn=#{node['fqdn']} gen-req server nopass",
      'creates' => "#{pki_dir}/private/server.key"
    },
    'sign server certificate request' => {
      'command' => "#{easy_rsa_bin} sign-req server server",
      'creates' => "#{pki_dir}/issued/server.crt"
    },
    'generate diffie hellman file' => {
      'command' => "#{easy_rsa_bin} gen-dh",
      'creates' => "#{pki_dir}/dh.pem"
    }
  }

  exec.each_pair do |desc, conf|
    execute desc do
      environment(env)
      command conf['command']
      creates conf['creates']
    end
  end

  psk = node[cookbook_name]['config'].dig('tls-auth')

  execute 'generate static pre shared key' do
    command "openvpn --genkey --secret #{psk}"
    cwd node[cookbook_name]['config_dir']
    creates "#{node[cookbook_name]['config_dir']}/#{psk}"
    not_if { psk.nil? }
  end
end

transform = proc do |hk, hv|
  hv.is_a?(Array) ? hv.map { |v| "#{hk} #{v}" } : "#{hk} #{hv}".strip
end

# Deploy OpenVPN configuration
auto_restart = node[cookbook_name]['auto_restart']

header = "# Produced by Chef -- changes will be overwritten\n"
common = node[cookbook_name]['config'].map(&transform)
config = node[cookbook_name]["#{type}_config"].map(&transform)
content = common.concat(config).flatten.sort

file node[cookbook_name]['config_file'] do
  content "#{header}\n#{content.join("\n")}\n"
  mode '0644'
  notifies :restart, "service[openvpn-#{type}@#{type}]" if auto_restart
end
