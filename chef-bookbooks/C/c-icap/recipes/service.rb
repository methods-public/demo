#
# Cookbook Name:: c-icap
# Recipe:: service
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

case node['platform']
  when "debian", "ubuntu"
    cicap_init = "c-icap.init.debian.erb"
  when "redhat", "centos", "amazon", "scientific"
    cicap_init = "c-icap.init.rhel.erb"
end

directory "/var/log/c-icap" do
  owner  node['c_icap']['user']
  group  node['c_icap']['group']
  mode   00744
  action :create
end

template "/etc/init.d/c-icap" do
  source cicap_init
  owner  "root"
  group  "root"
  mode   00744
end

template "#{node['c_icap']['config_dir']}/srv_url_check.conf" do
  source "srv_url_check.conf.erb"
  owner  node['c_icap']['user']
  group  node['c_icap']['group']
  mode   00644
  notifies :reload, "service[c-icap]", :delayed
end

template "#{node['c_icap']['config_dir']}/clamd_mod.conf" do
  source "clamd_mod.conf.erb"
  owner  node['c_icap']['user']
  group  node['c_icap']['group']
  mode   00644
  notifies :reload, "service[c-icap]", :delayed
end

template "#{node['c_icap']['config_dir']}/virus_scan.conf" do
  source "virus_scan.conf.erb"
  owner  node['c_icap']['user']
  group  node['c_icap']['group']
  mode   00644
  notifies :reload, "service[c-icap]", :delayed
end

template "#{node['c_icap']['config_dir']}/c-icap.conf" do
  source "c-icap.conf.erb"
  owner  node['c_icap']['user']
  group  node['c_icap']['group']
  mode   00644
  notifies :reload, "service[c-icap]", :delayed
end

template "/etc/default/c-icap" do
  source "c-icap-default.erb"
  owner  node['c_icap']['user']
  group  node['c_icap']['group']
  mode   00644
  notifies :reload, "service[c-icap]", :delayed
end

service "c-icap" do
  supports :restart => true, :reload => true, :status => true
  action [:enable, :start]
end
