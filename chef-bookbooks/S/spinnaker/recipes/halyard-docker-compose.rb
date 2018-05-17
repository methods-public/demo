#
# Cookbook Name:: spinnaker
# Recipe:: halyard-docker-compose
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

doc_url = 'https://www.spinnaker.io/setup/install/halyard/'

include_recipe 'platform_utils::kernel_user_namespace'
include_recipe 'docker-grid::compose'

app_dir = node['spinnaker']['halyard-docker-compose']['app_dir']
config_dir = node['spinnaker']['halyard-docker-compose']['config_dir']

[
  app_dir,
  config_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

config_srvs = node['spinnaker']['halyard-docker-compose']['config']['services']
override_config_srvs = node.override['spinnaker']['halyard-docker-compose']['config']['services']
#force_override_config_srvs = node.force_override['spinnaker']['halyard-docker-compose']['config']['services']
#halyard_envs_org = config_srvs['halyard']['environment']
#halyard_envs = {}
halyard_vols = config_srvs['halyard']['volumes'].to_a

ports = config_srvs['halyard']['ports']
if ports.empty?
  override_config_srvs['halyard']['ports'] = [
    '127.0.0.1:8064:8064',
  ]
end

halyard_vols.push("#{config_dir}:/root/.hal:rw")

# merge environment hash
#force_override_config_srvs['halyard']['environment'] = halyard_envs unless halyard_envs.empty?
# reset vlumes array.
override_config_srvs['halyard']['volumes'] = halyard_vols unless halyard_vols.empty?

config_file = "#{app_dir}/docker-compose.yml"
template config_file do
  source  'opt/docker-compose/app/halyard/docker-compose.yml'
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
  * Confirm:
    $ docker exec -it halyard_halyard_1 bash
    # hal -v
    0.32.1-20170816204345
  * Stop
    $ docker-compose down
EOM
