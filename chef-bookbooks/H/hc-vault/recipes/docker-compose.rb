#
# Cookbook Name:: hc-vault
# Recipe:: docker-compose
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

doc_url = 'https://hub.docker.com/_/vault/'

include_recipe 'platform_utils::kernel_user_namespace'
include_recipe 'docker-grid::compose'

vault_owner = node['hc-vault']['docker-compose']['vault_owner']
vault_group = node['hc-vault']['docker-compose']['vault_group']
app_dir = node['hc-vault']['docker-compose']['app_dir']
config_dir = node['hc-vault']['docker-compose']['config_dir']
file_dir = node['hc-vault']['docker-compose']['file_dir']
logs_dir = node['hc-vault']['docker-compose']['logs_dir']
certs_dir = node['hc-vault']['docker-compose']['certs_dir']

[
  app_dir,
  config_dir,
  certs_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

[
  file_dir,
  logs_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner vault_owner
    group vault_group
    mode '0755'
    recursive true
  end
}

override_vault_config = node.override['hc-vault']['config']
config_srvs = node['hc-vault']['docker-compose']['config']['services']
override_config_srvs = node.override['hc-vault']['docker-compose']['config']['services']
#force_override_config_srvs = node.force_override['hc-vault']['docker-compose']['config']['services']
#vault_envs_org = config_srvs['vault']['environment']
#vault_envs = {}
vault_vols = config_srvs['vault']['volumes'].to_a

ports = config_srvs['vault']['ports']
override_config_srvs['vault']['ports'] = ['8200:8200'] if ports.empty?

template "#{config_dir}/config.json" do
  source 'opt/docker-compose/app/vault/config/config.json'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

vault_vols.push("#{config_dir}/config.json:/vault/config/config.json:ro")
vault_vols.push("#{file_dir}:/vault/file:rw")
vault_vols.push("#{logs_dir}:/vault/logs:rw")

if node['hc-vault']['with_ssl_cert_cookbook']
  ::Chef::Recipe.send(:include, SSLCert::Helper)
  cn = node['hc-vault']['ssl_cert']['common_name']
  append_server_ssl_cn(cn)
  include_recipe 'ssl_cert::server_key_pairs'
  key_path = server_key_path(cn)

  # Because the Vault owner is not root.
  bash 'copy_ssl_server_key_for_hashicorp_vault' do
    code <<-EOH
      cp #{key_path} #{certs_dir}/server.key
      chown #{vault_owner} #{certs_dir}/server.key
      chmod 600 #{certs_dir}/server.key
    EOH
    sensitive true
    action :run
    not_if "cmp #{key_path} #{certs_dir}/server.key"
    #action :nothing
    #subscribes :run, "file[#{key_path}]"
  end

  vault_vols.push("#{server_cert_path(cn)}:/vault/server.crt:ro")
  vault_vols.push("#{certs_dir}/server.key:/vault/server.key:ro")
  override_vault_config['listener']['tcp'] = {
    'tls_disable' => false,
    'tls_cert_file' => '/vault/server.crt',
    'tls_key_file' => '/vault/server.key',
  }
end

# merge environment hash
#force_override_config_srvs['vault']['environment'] = vault_envs unless vault_envs.empty?
# reset vlumes array.
override_config_srvs['vault']['volumes'] = vault_vols unless vault_vols.empty?

config_file = "#{app_dir}/docker-compose.yml"
template config_file do
  source  'opt/docker-compose/app/vault/docker-compose.yml'
  owner 'root'
  group 'root'
  mode '0644'
end

log <<-"EOM"
Note: You must execute the following command manually.
  See #{doc_url}
  * Start:
    $ cd #{app_dir}
    $ docker-compose up -d
  * Stop
    $ docker-compose down
EOM
