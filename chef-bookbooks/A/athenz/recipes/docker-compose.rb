#
# Cookbook Name:: athenz
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

doc_url = 'https://hub.docker.com/r/athenz/athenz/'

include_recipe 'platform_utils::kernel_user_namespace'
include_recipe 'docker-grid::compose'

app_dir = node['athenz']['docker-compose']['app_dir']

[
  app_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

config_srvs = node['athenz']['docker-compose']['config']['services']
override_config_srvs = node.override['athenz']['docker-compose']['config']['services']
#force_override_config_srvs = node.force_override['athenz']['docker-compose']['config']['services']
#athenz_envs_org = config_srvs['athenz']['environment']
#athenz_envs = {}
athenz_vols = config_srvs['athenz']['volumes'].to_a

ports = config_srvs['athenz']['ports']
if ports.empty?
  override_config_srvs['athenz']['ports'] = [
    '4443:4443',
    '8443:8443',
    '9443:9443',
  ]
end

# merge environment hash
#force_override_config_srvs['athenz']['environment'] = athenz_envs unless athenz_envs.empty?
# reset vlumes array.
override_config_srvs['athenz']['volumes'] = athenz_vols unless athenz_vols.empty?

config_file = "#{app_dir}/docker-compose.yml"
template config_file do
  source  'opt/docker-compose/app/athenz/docker-compose.yml'
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
