#
# Cookbook:: alphard-chef-sbt
# Recipe:: default
#
# Copyright:: 2017, Hydra Technologies, Inc
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

include_recipe 'java'

sbt = node['alphard']['sbt']
user = sbt['user']
group = sbt['group']
home = sbt['home']
version = sbt['version']
archive_url = "https://dl.bintray.com/sbt/native-packages/sbt/#{version}/sbt-#{version}.tgz"
archive_directory = "#{Chef::Config['file_cache_path']}/sbt"
archive_file = "#{archive_directory}/sbt-#{version}.tgz"

directory archive_directory do
  owner user
  group group
  mode '0755'
  recursive true
  action :create
end

remote_file archive_file do
  source archive_url
  owner user
  group group
  mode '0755'
  action :create_if_missing
end

directory home do
  owner user
  group group
  mode '0755'
  recursive true
  action :create
  not_if { ::File.exist?(home.to_s) }
end

execute 'untar sbt' do
  command <<-EOH
    tar zxvf #{archive_file} -C #{archive_directory}
    mv #{archive_directory}/sbt-launcher-packaging-#{version}/* #{home}
  EOH
  not_if { ::File.exist?("#{home}/bin/sbt") }
end

link '/usr/local/bin/sbt' do
  to "#{home}/bin/sbt"
end
