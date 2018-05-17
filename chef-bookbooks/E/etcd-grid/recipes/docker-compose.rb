#
# Cookbook Name:: etcd-grid
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

doc_url = 'https://quay.io/repository/coreos/etcd'

include_recipe 'platform_utils::kernel_user_namespace'
include_recipe 'docker-grid::compose'

cluster_size = node['etcd-grid']['cluster']['size'].to_i
port4client = node['etcd-grid']['node']['port4client']
port4peer = node['etcd-grid']['node']['port4peer']
app_dir = node['etcd-grid']['docker-compose']['app_dir']
data_dir = node['etcd-grid']['docker-compose']['data_dir']

[
  app_dir,
  data_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

config_srvs = node['etcd-grid']['docker-compose']['config']['services']
override_config_srvs = node.override['etcd-grid']['docker-compose']['config']['services']
#force_override_config_srvs = node.force_override['etcd-grid']['docker-compose']['config']['services']

(1..cluster_size).each {|num|
  dir = "#{data_dir}/node#{num}.etcd"
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end

  next unless config_srvs["etcd#{num}"]['ports'].empty?
  override_config_srvs["etcd#{num}"]['ports'] = [
    "#{port4client}#{num}:#{port4client}",
    "#{port4peer}#{num}:#{port4peer}",
  ]
}

config_file = "#{app_dir}/docker-compose.yml"
template config_file do
  source  'opt/docker-compose/app/etcd/docker-compose.yml'
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
