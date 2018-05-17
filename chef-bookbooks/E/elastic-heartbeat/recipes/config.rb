#
# Cookbook Name:: elastic-heartbeat
# Recipe:: config
#
# Copyright 2017, Virender Khatri
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

directory node['heartbeat']['monitors_dir'] do
  recursive true
  action :create
end

file node['heartbeat']['conf_file'] do
  content JSON.parse(node['heartbeat']['config'].to_json).to_yaml.lines.to_a[1..-1].join
  notifies :restart, 'service[heartbeat]' if node['heartbeat']['notify_restart'] && !node['heartbeat']['disable_service']
end

ruby_block 'delay heartbeat service start' do
  block do
  end
  notifies :start, 'service[heartbeat]'
  not_if { node['heartbeat']['disable_service'] }
end

service_action = node['heartbeat']['disable_service'] ? %i[disable stop] : %i[enable nothing]

service 'heartbeat' do
  service_name node['heartbeat']['service_name']
  provider Chef::Provider::Service::Solaris if node['platform_family'] == 'solaris2'
  retries node['heartbeat']['service']['retries']
  retry_delay node['heartbeat']['service']['retry_delay']
  supports :status => true, :restart => true
  action service_action
end
