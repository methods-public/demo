#
# Cookbook Name:: dcos-grid
# Recipe:: bootstrap
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

include_recipe 'dcos-grid::node-commons'

genconf_dir = node['dcos-grid']['bootstrap']['genconf_dir']

validate_config_keys(node['dcos-grid']['bootstrap']['config'])

template "#{genconf_dir}/config.yaml" do
  source  'opt/dcos-grid/genconf/config.yaml'
  owner 'root'
  group 'root'
  mode '0644'
end

template "#{genconf_dir}/ip-detect" do
  source  'opt/dcos-grid/genconf/ip-detect'
  owner 'root'
  group 'root'
  mode '0755'
end

[
  'bootstrap_setup.sh',
  'bootstrap_upgrade.sh',
].each {|script_file|
  template "#{File.dirname(genconf_dir)}/#{script_file}" do
    source  "opt/dcos-grid/#{script_file}"
    owner 'root'
    group 'root'
    mode '0755'
  end
}

log <<-"EOM"
Note: You must execute the following command manually.
  - Install:
    $ #{File.dirname(node['dcos-grid']['bootstrap']['genconf_dir'])}/bootstrap_setup.sh
  - Upgrade:
    $ #{File.dirname(node['dcos-grid']['bootstrap']['genconf_dir'])}/bootstrap_upgrade.sh
EOM
