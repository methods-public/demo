#
# Cookbook Name:: netdevops
# Recipe:: rhel
#
# Copyright 2015 John Deatherage
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

include_recipe 'yum-epel::default'

node['netdevops']['package']['rhel'].each do |pkg|
  package pkg do
    action :install
  end
end

package 'python-virtinst' do
  action :install
  only_if { node['platform_version'].to_i < 7.0 }
end

node['netdevops']['package']['epel'].each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['netdevops']['vagrant']['rhel']['package']}" do
  source "#{node['netdevops']['vagrant']['rhel']['url']}#{node['netdevops']['vagrant']['rhel']['package']}"
  checksum node['netdevops']['vagrant']['rhel']['checksum']
end

rpm_package 'vagrant' do
  source "#{Chef::Config[:file_cache_path]}/#{node['netdevops']['vagrant']['rhel']['package']}"
  action :install
end

# contrail package installs for CentOS/RHEL should go here
# no publicly-available package repo - check w/Contrail team
