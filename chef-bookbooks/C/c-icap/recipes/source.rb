#
# Cookbook Name:: c-icap
# Recipe:: source
# Author:: Rostyslav Fridman (<rostyslav.fridman@gmail.com>)
#
# Copyright 2014, Rostyslav Fridman
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

include_recipe "checkinstall::default"

remote_file "#{Chef::Config['file_cache_path']}/c_icap-#{node['c_icap']['version']}.tar.gz" do
  source   "#{node['c_icap']['url']}/c_icap-#{node['c_icap']['version']}.tar.gz"
  checksum node['c_icap']['checksum']
  mode     00644
end

directory "/var/run/c-icap" do
  owner   node['c_icap']['user']
  group   node['c_icap']['owner']
  mode    00755
  action  :create
end

directory node['c_icap']['config_dir'] do
  owner   node['c_icap']['user']
  group   node['c_icap']['owner']
  mode    00755
  action  :create
end

# debian/ubuntu use the following version scheme for c-icap in default repo - 1:version
# to avoid the "upgrades" to the older package, we modify the version
case node['platform']
  when "debian", "ubuntu"
    c_icap_version = "1:#{node['c_icap']['version']}"
  when "redhat", "centos", "amazon", "scientific"
    c_icap_version = node['c_icap']['version']
end

checkinstall_package "c-icap" do
  source_archive "#{Chef::Config['file_cache_path']}/c_icap-#{node['c_icap']['version']}.tar.gz"
  configure_options node['c_icap']['configure_options']
  version c_icap_version
end

remote_file "#{Chef::Config['file_cache_path']}/c_icap_modules-#{node['c_icap_modules']['version']}.tar.gz" do
  source   "#{node['c_icap_modules']['url']}/c_icap_modules-#{node['c_icap_modules']['version']}.tar.gz"
  checksum node['c_icap_modules']['checksum']
  mode     00644
end

checkinstall_package "c-icap-modules" do
  source_archive "#{Chef::Config['file_cache_path']}/c_icap_modules-#{node['c_icap_modules']['version']}.tar.gz"
  configure_options node['c_icap_modules']['configure_options']
  version node['c_icap_modules']['version']
  binary_location "#{node['c_icap']['modules_dir']}/srv_url_check.so"
end
