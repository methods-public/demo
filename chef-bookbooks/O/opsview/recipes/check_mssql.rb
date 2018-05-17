#
# Cookbook Name:: opsview
# Recipe:: check_mssql
#
# Copyright 2015, Biola University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install DBD::Sybase Perl module
package "libdbd-sybase-perl"

# Search for SQL Servers to monitor
mssql_servers = search(:node, "roles:#{node['opsview']['check_mssql']['monitored_server_role']}")
mssql_servers.sort! { |a, b| a.name <=> b.name }

# Replace the default FreeTDS config
template "/etc/freetds/freetds.conf" do
  source "freetds.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(:mssql_servers => mssql_servers)
end

# Build and install the check_mssql_health plugin
include_recipe 'ark::default'

ark "check_mssql_health" do
  url node['opsview']['check_mssql']['plugin_url']
  checksum node['opsview']['check_mssql']['plugin_checksum']
  version node['opsview']['check_mssql']['plugin_version']
  autoconf_opts [
    '--prefix=/usr/local/nagios',
    '--with-nagios-user=nagios',
    '--with-nagios-group=nagios',
    '--with-perl=/usr/bin/perl',
    "--with-statefiles-dir=#{node['opsview']['check_mssql']['statefiles_dir']}"
  ]
  prefix_root Chef::Config[:file_cache_path]
  creates '/usr/local/nagios/libexec/check_mssql_health'
  action :install_with_make
end
