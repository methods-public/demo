#
# Cookbook Name:: dbforbix
# Recipe:: drivers
#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Author:: Tiago Cruz (tiago.cruz@movile.com)
#
# Copyright:: 2017-2018, Movile
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

include_recipe 'dbforbix'

directory node['dbforbix']['lib_dir'] do
  owner 'dbforbix'
  group 'dbforbix'
  mode 0755
end

# mssql
if node['dbforbix']['drivers']['mssql']

  url = node['dbforbix']['driver_mssql']
  filename = File.basename(URI.parse(url).path)

  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source node['dbforbix']['driver_mssql']
    checksum node['dbforbix']['driver_mssql_checksum']
    notifies :run, 'execute[install dbforbix mssql driver]', :immediately
  end

  execute 'install dbforbix mssql driver' do
    action :nothing
    user 'dbforbix'
    command "tar -C #{node['dbforbix']['lib_dir']} --strip-component=2 -zpvxf #{Chef::Config[:file_cache_path]}/#{filename} sqljdbc_6.2/enu/mssql-jdbc-6.2.2.jre8.jar"
    notifies :restart, 'service[dbforbix]', :delayed
  end
end
