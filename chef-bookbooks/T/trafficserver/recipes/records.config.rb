#
# Cookbook Name:: trafficserver
# Recipe:: records.config
#
# Copyright 2014, Virender Khatri
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

template ::File.join(node['trafficserver']['conf_dir'], 'records.config') do
  cookbook node['trafficserver']['cookbook']
  source 'records.config.erb'
  owner node['trafficserver']['user']
  group node['trafficserver']['group']
  mode 0600
  variables(:log_dir => node['trafficserver']['log_dir'])
  notifies :reload, 'service[trafficserver]', :delayed if node['trafficserver']['notify_restart']
  only_if { node['trafficserver']['manage_config'] }
  action :create_if_missing
end
