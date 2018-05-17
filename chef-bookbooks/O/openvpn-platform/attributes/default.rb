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

cookbook_name = 'openvpn-platform'

# Packages to install
default[cookbook_name]['packages'] = {
  'centos' => %w[bridge-utils easy-rsa openssl openvpn]
}

# OpenVPN mode (value: client|server)
# Generation of PKI is only handled for server type
default[cookbook_name]['type'] = 'server'
type = node[cookbook_name]['type']

# OpenVPN directory
default[cookbook_name]['config_dir'] = "/etc/openvpn/#{type}"
config_dir = node[cookbook_name]['config_dir']

# OpenVPN configuration file
default[cookbook_name]['config_file'] = "#{config_dir}/#{type}.conf"

# PKI directory
default[cookbook_name]['pki_dir'] = "#{config_dir}/pki"
pki_dir = node[cookbook_name]['pki_dir']

# Easy RSA directory
default[cookbook_name]['easy_rsa']['dir'] = '/usr/share/easy-rsa/3'
easy_rsa_dir = node[cookbook_name]['easy_rsa']['dir']

# Easy RSA environment configuration
default[cookbook_name]['easy_rsa']['vars'] = {
  'EASYRSA_BATCH' => '1',
  'EASYRSA_PKI' => pki_dir,
  'EASYRSA_SSL_CONF' => "#{easy_rsa_dir}/openssl-1.0.cnf"
}

# OpenVPN configuration
# Each hash key is an OpenVPN directive.
# If the same directive is needed many times, value should be an array
default[cookbook_name]['config'] = {
  'proto' => 'udp',
  'dev' => 'tun',
  'tls-auth' => 'ta.key',
  'persist-key' => '',
  'persist-tun' => '',
  'cipher' => 'AES-256-CBC',
  'verb' => 3
}

# Server-specific configuration
default[cookbook_name]['server_config'] = {
  'port' => 1194,
  'server' => '10.8.0.0 255.255.255.0',
  'ca' => "#{pki_dir}/ca.crt",
  'cert' => "#{pki_dir}/issued/server.crt",
  'dh' => "#{pki_dir}/dh.pem",
  'key' => "#{pki_dir}/private/server.key",
  'ifconfig-pool-persist' => 'ipp.txt',
  'keepalive' => '10 120',
  'status' => 'openvpn-status.log',
  'explicit-exit-notify' => 1
}

# Client-specific configuration
default[cookbook_name]['client_config'] = {
  'client' => '',
  'remote' => "my-server-1 #{node[cookbook_name]['server_config']['port']}",
  'resolv-retry' => 'infinite',
  'nobind' => '',
  'remote-cert-tls' => 'server'
}

# Data bag to manage OpenVPN clients
default[cookbook_name]['data_bag'] = nil

# OpenVPN clients tarball
default[cookbook_name]['tarball'] = 'openvpn.tar.gz'

# If OpenVPN service is restarted when config file changes
default[cookbook_name]['auto_restart'] = true

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
