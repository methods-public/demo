#
# Cookbook Name:: dcos-grid
# Recipe:: master
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

include_recipe 'dcos-grid::node'

if node['dcos-grid']['node']['auto_setup']
  bash 'setup_master_node' do
    code <<-"EOH"
      cd #{File.dirname(node['dcos-grid']['bootstrap']['genconf_dir'])}
      ./node_setup.sh -y master
    EOH
    not_if { ::Dir.exist?('/opt/mesosphere') }
  end
else
  log <<-"EOM"
Note: You must execute the following command.
  - Install (only once):
    $ #{File.dirname(node['dcos-grid']['bootstrap']['genconf_dir'])}/node_setup.sh master
  - Upgrade:
    $ #{File.dirname(node['dcos-grid']['bootstrap']['genconf_dir'])}/node_upgrade.sh master
  EOM
end
