#
# Cookbook Name:: chef_server_omnibus
# Recipe:: analytics
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

# Install Chef Server (and configure)
chef_server_ingredient 'opscode-analytics' do
  action :install
end

directory node['chef_server_omnibus']['analytics']['config_dir'] do
  owner 'root'
  group 'root'
  mode '0644'
end

template "#{node['chef_server_omnibus']['analytics']['config_dir']}/opscode-analytics.rb" do #~FC037
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reconfigure, 'chef_server_omnibus_service[opscode-analytics]', :immediately
  if node['chef_server_omnibus']['analytics']['topology'] == 'combined'
    subscribes :reconfigure, 'chef_server_omnibus_service[chef-server]'
  end
end

chef_server_omnibus_service 'opscode-analytics' do
  start_command "#{node['chef_server_omnibus']['analytics_ctl_path']} start"
  stop_command "#{node['chef_server_omnibus']['analytics_ctl_path']} stop"
  status_command "#{node['chef_server_omnibus']['analytics_ctl_path']} status"
  restart_command "#{node['chef_server_omnibus']['analytics_ctl_path']} restart"
  reconfigure_command "#{node['chef_server_omnibus']['analytics_ctl_path']} reconfigure"
  action :start
  supports restart: true, status: true
end
