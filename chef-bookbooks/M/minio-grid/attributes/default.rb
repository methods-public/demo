#
# Cookbook Name:: minio-grid
# Attributes:: default
#
# Copyright 2018, whitestar
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

default['minio-grid']['with_ssl_cert_cookbook'] = false
# If ['minio-grid']['with_ssl_cert_cookbook'] is true,
# node['minio-grid']['docker-compose']['config']
# are overridden by the following 'common_name' attributes.
default['minio-grid']['ssl_cert']['common_name'] = node['fqdn']

default['minio-grid']['access_key_vault_item'] = {
=begin
  'vault' => 'minio',
  'name' => 'access_key',
  # single key id or nested hash key id path delimited by slash
  'env_context' => false,
  'key' => 'kid',  # real hash path: "/kid"
  # or nested hash key id path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/kid',  # real hash path: "/#{node.chef_environment}/hash/path/to/kid"
=end
}
default['minio-grid']['secret_key_vault_item'] = {
=begin
  'vault' => 'minio',
  'name' => 'access_key',
  # single key secret or nested hash key secret path delimited by slash
  'env_context' => false,
  'key' => 'secret',  # real hash path: "/secret"
  # or nested hash key secret path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/secret',  # real hash path: "/#{node.chef_environment}/hash/path/to/secret"
=end
}

default['minio-grid']['docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/minio"
default['minio-grid']['docker-compose']['config_dir'] = "#{node['minio-grid']['docker-compose']['app_dir']}/config"
default['minio-grid']['docker-compose']['data_dir'] = "#{node['minio-grid']['docker-compose']['app_dir']}/data"

force_override['minio-grid']['docker-compose']['config_format_version'] = '2'
version_2_config = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    'minio' => {
      'restart' => 'always',
      'image' => 'minio/minio',
      'command' => 'server /data',
      'ports' => [
        #'9000:9000',  # default
      ],
      'volumes' => [
        # These volumes will be set by the minio-grid::docker-compose recipe automatically.
        #"#{node['minio-grid']['docker-compose']['config_dir']}:/root/.minio:rw",
        #"#{node['minio-grid']['docker-compose']['data_dir']}:/data:rw",
        #"#{server_cert_path(node['minio-grid']['ssl_cert']['common_name'])}:/root/.minio/certs/public.crt:ro",
        #"#{server_key_path(node['minio-grid']['ssl_cert']['common_name'])}:/root/.minio/certs/private.key:ro",
      ],
      'environment' => {
        # See https://docs.minio.io/
        #'MINIO_REGION' => 'us-east-1',
        #'MINIO_BROWSER' => 'on',
        #'MINIO_DOMAIN' => 'minio.example.com',  # for virtual-host-style requests
        # These variables will be set by the minio-grid::docker-compose recipe automatically.
        #'MINIO_ACCESS_KEY' => '${MINIO_ACCESS_KEY}',
        #'MINIO_SECRET_KEY' => '${MINIO_SECRET_KEY}',
      },
    },
  },
}

default['minio-grid']['docker-compose']['config'] = version_2_config
