#
# Cookbook Name:: cdap
# Recipe:: default
#
# Copyright © 2013-2017 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Installs base package, creates log directory, and write out CDAP configuration
include_recipe 'cdap::base'

if cdap_property?('log_dir', 'cdap_env')
  cdap_log_dir = node['cdap']['cdap_env']['log_dir']

  directory cdap_log_dir do
    owner 'cdap'
    group 'cdap'
    mode '0755'
    action :create
    recursive true
    only_if { cdap_property?('log_dir', 'cdap_env') }
  end

  unless cdap_log_dir == '/var/log/cdap'
    # Delete default directory, if we aren't set to it
    directory '/var/log/cdap' do
      action :delete
      not_if 'test -L /var/log/cdap'
    end
    # symlink
    link '/var/log/cdap' do
      to cdap_log_dir
    end
  end
end

include_recipe 'cdap::config'
