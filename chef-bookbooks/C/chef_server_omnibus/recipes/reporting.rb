#
# Cookbook Name:: chef_server_omnibus
# Recipe:: reporting
#
# Copyright 2015 Drew A. Blessing
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

# Reporting requires Manage
include_recipe 'chef_server_omnibus::manage'

chef_server_ingredient 'opscode-reporting' do
  action :install
  notifies :reconfigure, 'chef_server_omnibus_service[chef-server]', :immediately
  notifies :reconfigure, 'chef_server_omnibus_service[opscode-reporting]', :immediately
end

# Avoid an infinite loop above by making opscode-reporting a 'service' that we can reconfigure.
chef_server_omnibus_service 'opscode-reporting' do
  reconfigure_command "#{node['chef_server_omnibus']['opscode_reporting_ctl_path']} reconfigure"
  action :nothing
end
