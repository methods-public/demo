#
# Cookbook Name:: dcos-grid
# Recipe:: cloud-config
#
# Copyright 2016, whitestar
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

::Chef::Recipe.send(:include, DCOSGrid::Helper)

node.override['dcos-grid']['bootstrap']['genconf_dir'] \
  = "#{node['dcos-grid']['cloud-config']['target_dir']}/genconf"
genconf_dir = node['dcos-grid']['bootstrap']['genconf_dir']

resources(directory: genconf_dir) rescue directory genconf_dir do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

validate_config_keys(node['dcos-grid']['bootstrap']['config'])

template "#{File.dirname(genconf_dir)}/cloud-config.yaml" do
  source  'opt/dcos-grid/cloud-config.yaml'
  owner 'root'
  group 'root'
  mode '0644'
end

log <<-EOM
Info: You can install CoreOS with DC/OS setup scripts by the the cloud-config.yaml.
  $ coreos-cloudinit -from-file ~/cloud-config.yaml -validate
  ...
  $ sudo coreos-install -d /dev/sda -C stable -c ~/cloud-config.yaml
EOM
