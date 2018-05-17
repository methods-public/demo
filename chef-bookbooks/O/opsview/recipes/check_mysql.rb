#
# Cookbook Name:: opsview
# Recipe:: check_mysql
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

# Install DBD::MySQL Perl module
package "libdbd-mysql-perl"

# Build and install the check_mysql_health plugin
include_recipe 'ark::default'

ark "check_mysql_health" do
  url node['opsview']['check_mysql']['plugin_url']
  checksum node['opsview']['check_mysql']['plugin_checksum']
  version node['opsview']['check_mysql']['plugin_version']
  autoconf_opts [
    '--prefix=/usr/local/nagios',
    '--with-nagios-user=nagios',
    '--with-nagios-group=nagios',
    '--with-perl=/usr/bin/perl',
    "--with-statefiles-dir=#{node['opsview']['check_mysql']['statefiles_dir']}"
  ]
  prefix_root Chef::Config[:file_cache_path]
  creates '/usr/local/nagios/libexec/check_mysql_health'
  action :install_with_make
end