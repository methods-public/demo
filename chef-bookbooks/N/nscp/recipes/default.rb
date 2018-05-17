#
# Cookbook Name:: nscp
# Recipe:: default
# Author:: Azat Khadiev <anuriq@gmail.com>
#
# Copyright (C) 2016, Parallels IP Holdings GmbH.
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

unless node['platform_family'] == 'windows'
  return "NSCP install not supported on #{node['platform_family']}."
end

include_recipe 'chocolatey'
chocolatey 'nscp'

nscp_dir = "#{ENV['SystemDrive']}\\Program Files\\NSClient++"
node.default['nscp']['dir'] = nscp_dir
node.default['nscp']['scripts_dir'] = "#{nscp_dir}\\scripts"

template 'nscp_config' do
  path "#{nscp_dir}\\nsclient.ini"
  cookbook node['nscp']['template_cookbook']
  source node['nscp']['template_name']
  notifies :restart, "service[#{node['nscp']['service_name']}]", :immediately
end

service node['nscp']['service_name'] do
  supports start: true, stop: true, restart: true
  action [:start, :enable]
end
