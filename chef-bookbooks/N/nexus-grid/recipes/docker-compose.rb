#
# Cookbook Name:: nexus-grid
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

include_recipe 'platform_utils::kernel_user_namespace'
include_recipe 'docker-grid::compose'

app_dir = node['nexus-grid']['docker-compose']['app_dir']
etc_dir = node['nexus-grid']['docker-compose']['etc_dir']
data_dir = node['nexus-grid']['docker-compose']['data_dir']

[
  app_dir,
  "#{etc_dir}/nginx",
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

config_srvs = node['nexus-grid']['docker-compose']['config']['services']
override_config_srvs = node.override['nexus-grid']['docker-compose']['config']['services']
#force_override_config_srvs = node.force_override['nexus-grid']['docker-compose']['config']['services']
#nexus_envs_org = config_srvs['nexus']['environment']
#nexus_envs = {}
rproxy_vols = config_srvs['reverseproxy']['volumes'].to_a
nexus_vols = config_srvs['nexus']['volumes'].to_a

nexus_ver = config_srvs['nexus']['image'] =~ %r{^sonatype/nexus3} ? '3' : '2'
doc_url = 'https://hub.docker.com/r/sonatype'
doc_url = nexus_ver == '3' ? "#{doc_url}/nexus3/" : "#{doc_url}/nexus/"

ports = config_srvs['reverseproxy']['ports']
override_config_srvs['reverseproxy']['ports'] = ['8081:8081'] if ports.empty?

template "#{etc_dir}/nginx/nginx.conf" do
  source 'opt/docker-compose/app/nexus/etc/nginx/nginx.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables(
    nexus_ver: nexus_ver
  )
end

rproxy_vols.push("#{etc_dir}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro")

# Data persistent
resources(directory: data_dir) rescue directory data_dir do
  owner 200
  group 'root'
  mode '0700'
  recursive true
end if !data_dir.nil? && !data_dir.empty?

container_data_dir = nexus_ver == '3' ? '/nexus-data' : '/sonatype-work'
nexus_vols.push("#{data_dir}:#{container_data_dir}:rw") if !data_dir.nil? && !data_dir.empty?

if node['nexus-grid']['with_ssl_cert_cookbook']
  ::Chef::Recipe.send(:include, SSLCert::Helper)
  cn = node['nexus-grid']['ssl_cert']['common_name']
  append_server_ssl_cn(cn)
  include_recipe 'ssl_cert::server_key_pairs'
  # Nginx parent process owner is root.
  rproxy_vols.push("#{server_cert_path(cn)}:/root/server.crt:ro")
  rproxy_vols.push("#{server_key_path(cn)}:/root/server.key:ro")
end

=begin
if node['nexus-grid']['https_enabled']
  # TODO: TLS conf. for built-in jetty
  data_etc_dir = "#{data_dir}/etc"
  resources(directory: data_etc_dir) rescue directory data_etc_dir do
    owner 200
    group 200
    mode '0755'
    recursive true
  end

  template "#{data_etc_dir}/nexus.properties" do
    source 'opt/docker-compose/app/nexus/data/etc/nexus.properties'
    owner 200
    group 200
    mode '0644'
    action :create
  end

  nexus_ports = config_srvs['nexus']['ports']
  override_config_srvs['nexus']['ports'] = ['8443:8443'] if nexus_ports.empty?
end
=end

# merge environment hash
#force_override_config_srvs['nexus']['environment'] = nexus_envs unless nexus_envs.empty?
# reset vlumes array.
override_config_srvs['reverseproxy']['volumes'] = rproxy_vols unless rproxy_vols.empty?
override_config_srvs['nexus']['volumes'] = nexus_vols unless nexus_vols.empty?

config_file = "#{app_dir}/docker-compose.yml"
template config_file do
  source  'opt/docker-compose/app/nexus/docker-compose.yml'
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
