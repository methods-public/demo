#
# Cookbook Name:: minio-grid
# Recipe:: docker-compose
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

doc_url = 'https://hub.docker.com/r/minio/minio/'

include_recipe 'platform_utils::kernel_user_namespace'
include_recipe 'docker-grid::compose'

app_dir = node['minio-grid']['docker-compose']['app_dir']
config_dir = node['minio-grid']['docker-compose']['config_dir']
certs_dir = "#{config_dir}/certs"
data_dir = node['minio-grid']['docker-compose']['data_dir']

[
  app_dir,
  config_dir,
  certs_dir,
  data_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

#override_minio_config = node.override['minio-grid']['config']
config_srvs = node['minio-grid']['docker-compose']['config']['services']
override_config_srvs = node.override['minio-grid']['docker-compose']['config']['services']
force_override_config_srvs = node.force_override['minio-grid']['docker-compose']['config']['services']
#minio_envs_org = config_srvs['minio']['environment']
minio_envs = {}
minio_vols = config_srvs['minio']['volumes'].to_a

ports = config_srvs['minio']['ports']
override_config_srvs['minio']['ports'] = ['9000:9000'] if ports.empty?

minio_vols.push("#{config_dir}:/root/.minio:rw")
minio_vols.push("#{data_dir}:/data:rw")

access_key = nil
access_key_vault_item = node['minio-grid']['access_key_vault_item']
unless access_key_vault_item.empty?
  access_key = get_vault_item_value(access_key_vault_item)
  minio_envs['MINIO_ACCESS_KEY'] = '${MINIO_ACCESS_KEY}'
end

secret_key = nil
secret_key_vault_item = node['minio-grid']['secret_key_vault_item']
unless secret_key_vault_item.empty?
  secret_key = get_vault_item_value(secret_key_vault_item)
  minio_envs['MINIO_SECRET_KEY'] = '${MINIO_SECRET_KEY}'
end

if node['minio-grid']['with_ssl_cert_cookbook']
  ::Chef::Recipe.send(:include, SSLCert::Helper)
  cn = node['minio-grid']['ssl_cert']['common_name']
  append_server_ssl_cn(cn)
  include_recipe 'ssl_cert::server_key_pairs'

  minio_vols.push("#{server_cert_path(cn)}:/root/.minio/certs/public.crt:ro")
  minio_vols.push("#{server_key_path(cn)}:/root/.minio/certs/private.key:ro")
end

# merge environment hash
force_override_config_srvs['minio']['environment'] = minio_envs unless minio_envs.empty?
# reset vlumes array.
override_config_srvs['minio']['volumes'] = minio_vols unless minio_vols.empty?

config_file = "#{app_dir}/docker-compose.yml"
template config_file do
  source  'opt/docker-compose/app/minio/docker-compose.yml'
  owner 'root'
  group 'root'
  mode '0644'
end

env_file = "#{app_dir}/.env"
template env_file do
  source 'opt/docker-compose/app/minio/.env'
  owner 'root'
  group 'root'
  mode '0600'
  sensitive true
  # prevent Chef from logging password attribute value.
  variables(
    # secrets
    access_key: access_key,
    secret_key: secret_key
  )
end

log 'minio docker-compose post install message' do
  message <<-"EOM"
Note: You must execute the following command manually.
  See #{doc_url}
  * Start:
    $ cd #{app_dir}
    $ docker-compose up -d
  * Stop
    $ docker-compose down
EOM
end
