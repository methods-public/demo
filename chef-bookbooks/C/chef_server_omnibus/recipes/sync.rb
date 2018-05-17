#
# Cookbook Name:: chef_server_omnibus
# Recipe:: chef-sync
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

include_recipe 'chef_server_omnibus'

directory node['chef_server_omnibus']['sync']['config_dir'] do
  owner 'root'
  group 'root'
  mode '0644'
end

template "#{node['chef_server_omnibus']['sync']['config_dir']}/chef-sync.rb" do #~FC037
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reconfigure, 'chef_server_omnibus_service[chef-sync]', :immediately
  subscribes :reconfigure, 'chef_server_omnibus_service[chef-server]'
end

chef_server_ingredient 'chef-sync' do
  action :install
  reconfigure true
  notifies :reconfigure, 'chef_server_omnibus_service[chef-server]', :immediately
  notifies :reconfigure, 'chef_server_omnibus_service[chef-sync]', :immediately
end

# Avoid an infinite loop above by making opscode-reporting a 'service' that we can reconfigure.
chef_server_omnibus_service 'chef-sync' do
  reconfigure_command "#{node['chef_server_omnibus']['chef_sync_ctl_path']} reconfigure"
  action :nothing
end
