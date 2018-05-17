#
# Copyright (c) 2017 Sam4Mobile, 2017-2018 Make.org
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

# Java packages are needed by cassandra, can install it with package
java_package = node[cookbook_name]['java'][node['platform']]

package_retries = node[cookbook_name]['package_retries']
package java_package do
  version node[cookbook_name]['java']['version']
  retries package_retries unless package_retries.nil?
  not_if java_package.to_s.empty?
  action :upgrade if node[cookbook_name]['java']['version'] == 'latest'
end

# Create prefix directories
[
  node[cookbook_name]['prefix_root'],
  node[cookbook_name]['prefix_home'],
  node[cookbook_name]['prefix_bin']
].uniq.each do |dir_path|
  directory "#{cookbook_name}:#{dir_path}" do
    path dir_path
    mode '0755'
    recursive true
    action :create
  end
end

ark 'cassandra' do
  action :install
  url node[cookbook_name]['url']
  prefix_root node[cookbook_name]['prefix_root']
  prefix_bin node[cookbook_name]['prefix_bin']
  prefix_home node[cookbook_name]['prefix_home']
  has_binaries []
  checksum node[cookbook_name]['checksum']
  version node[cookbook_name]['version']
  owner node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

directory node[cookbook_name]['data_dir'] do
  recursive true
  mode '0755'
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
  action :create
end

link "#{node[cookbook_name]['prefix_home']}/cassandra/data" do
  to node[cookbook_name]['data_dir']
  link_type :symbolic
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end
