#
# Cookbook Name:: opsview
# Recipe:: check_oracle
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

# Install Oracle Instant Client and dependencies
include_recipe "oracle_instant_client::default"
package "libdbi-perl"

# Build and install DBD::Oracle
remote_file "#{Chef::Config[:file_cache_path]}/DBD-Oracle-#{node['opsview']['check_oracle']['dbd_oracle_version']}.tar.gz" do
  source node['opsview']['check_oracle']['dbd_oracle_url']
  checksum node['opsview']['check_oracle']['dbd_oracle_checksum']
  action :create_if_missing
end

lib_path = Dir[File.join(node['oracle_instant_client']['base_dir'], 'instantclient*')].find { |f| File.directory?(f) }
if lib_path
  bash 'build-dbd-oracle' do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
      tar zxvf DBD-Oracle-#{node['opsview']['check_oracle']['dbd_oracle_version']}.tar.gz
      cd DBD-Oracle-#{node['opsview']['check_oracle']['dbd_oracle_version']}
      perl Makefile.PL
      make
      make install
    EOH
    environment 'LD_LIBRARY_PATH' => lib_path
    creates '/usr/local/lib/perl/5.14.2/DBD/Oracle.pm'
  end

  # Build and install the check_oracle_health plugin
  include_recipe 'ark::default'

  ark "check_oracle_health" do
    url node['opsview']['check_oracle']['plugin_url']
    checksum node['opsview']['check_oracle']['plugin_checksum']
    version node['opsview']['check_oracle']['plugin_version']
    autoconf_opts [
      '--prefix=/usr/local/nagios',
      '--with-nagios-user=nagios',
      '--with-nagios-group=nagios',
      '--with-perl=/usr/bin/perl',
      "--with-statefiles-dir=#{node['opsview']['check_oracle']['statefiles_dir']}"
    ]
    prefix_root Chef::Config[:file_cache_path]
    creates '/usr/local/nagios/libexec/check_oracle_health'
    action :install_with_make
  end
end