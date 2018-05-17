#
# Cookbook Name:: hc-vault
# Attributes:: default
#
# Copyright 2017, whitestar
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

default['hc-vault']['with_ssl_cert_cookbook'] = false
# If ['hc-vault']['with_ssl_cert_cookbook'] is true,
# node['hc-vault']['docker-compose']['config']
# are overridden by the following 'common_name' attributes.
default['hc-vault']['ssl_cert']['common_name'] = node['fqdn']

# This Hash is expanded to a `/vault/config/config.json` in Docker container.
# see https://www.vaultproject.io/docs/configuration/index.html
default['hc-vault']['config'] = {
  'listener' => {
    'tcp' => {
      'address' => '0.0.0.0:8200',
      # These configurations will be set by the hc-vault::docker-compose recipe automatically.
      'tls_disable' => true,  # default: false
      #'tls_cert_file' => '/vault/server.crt',
      #'tls_key_file' => '/vault/server.key',
    },
  },
  'backend' => {
    'file' => {
      'path' => '/vault/file',
    },
  },
  'default_lease_ttl' => '768h',
  'max_lease_ttl' => '768h',
}

force_override['hc-vault']['docker-compose']['vault_owner'] = 100
force_override['hc-vault']['docker-compose']['vault_group'] = 1000
default['hc-vault']['docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/vault"
default['hc-vault']['docker-compose']['config_dir'] = "#{node['hc-vault']['docker-compose']['app_dir']}/config"
default['hc-vault']['docker-compose']['file_dir'] = "#{node['hc-vault']['docker-compose']['app_dir']}/file"
default['hc-vault']['docker-compose']['logs_dir'] = "#{node['hc-vault']['docker-compose']['app_dir']}/logs"
default['hc-vault']['docker-compose']['certs_dir'] = "#{node['hc-vault']['docker-compose']['app_dir']}/certs"

force_override['hc-vault']['docker-compose']['config_format_version'] = '2'
version_2_config = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    'vault' => {
      'cap_add' => [
        'IPC_LOCK',
      ],
      'restart' => 'always',
      'image' => 'vault:latest',
      'command' => 'server',
      'ports' => [
        #'8200:8200',
      ],
      'volumes' => [
        # These volumes will be set by the hc-vault::docker-compose recipe automatically.
        #"#{node['hc-vault']['docker-compose']['config_dir']}/config.json:/vault/config/config.json:ro",
        #"#{node['hc-vault']['docker-compose']['file_dir']}:/vault/file:rw",
        #"#{node['hc-vault']['docker-compose']['logs_dir']}:/vault/logs:rw",
        #"#{server_cert_path(node['hc-vault']['ssl_cert']['common_name'])}:/vault/server.crt:ro",
        #"#{node['hc-vault']['docker-compose']['certs_dir']}/server.key:/vault/server.key:ro",
      ],
      'environment' => {
        # use the ['hc-vault']['config'] attribute instead of this variable.
        #'VAULT_LOCAL_CONFIG' => '',  # expanded to /vault/config/local.json
      },
    },
  },
}

default['hc-vault']['docker-compose']['config'] = version_2_config
