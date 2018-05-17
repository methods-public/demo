#
# Copyright (c) 2015-2016 Sam4Mobile
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

# tar may not be installed by default
package 'tar'

# Shorten variables
version = node['storm-platform']['version']
storm_url = "#{node['storm-platform']['mirror']}/apache-storm-#{version}"
storm_artifact = "apache-storm-#{version}.tar.gz"

# Create prefix directories
[
  node['storm-platform']['prefix_root'],
  node['storm-platform']['prefix_home'],
  node['storm-platform']['prefix_bin']
].uniq.each do |dir_path|
  directory "storm-platform:#{dir_path}" do
    path dir_path
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end
end

# Install storm package with ark
ark 'storm' do
  action :install
  url "#{storm_url}/#{storm_artifact}"
  prefix_root node['storm-platform']['prefix_root']
  prefix_home node['storm-platform']['prefix_home']
  prefix_bin node['storm-platform']['prefix_bin']
  has_binaries ['bin/storm']
  checksum node['storm-platform']['checksum']
  version node['storm-platform']['version']
end
