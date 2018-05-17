#
# Cookbook Name:: apache2-windows
# Recipe:: default
#
# Copyright 2013-2017, Chef Software, Inc.
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

require 'chef/exceptions'

unless node['platform_family'] == 'windows'
  raise Chef::Exceptions::Application, 'This cookbook only works on Microsoft Windows.'
end

package node['apache']['windows']['display_name'] do
  source node['apache']['windows']['source']
  # The latter four of these options are just to keep the Apache2 service
  # from failing before rendering the actual httpd.conf.
  options %W(
    /quiet
    INSTALLDIR="#{node['apache']['windows']['dir']}"
    ALLUSERS=1
    SERVERADMIN=#{node['apache']['windows']['serveradmin']}
    SERVERDOMAIN=#{node['fqdn']}
    SERVERNAME=#{node['fqdn']}
  ).join(' ')
end

template node['apache']['windows']['conf'] do
  source 'httpd.conf.erb'
  action :create
  notifies :restart, 'service[apache2]'
end

node['apache']['windows']['extras'].each do |extra|
  include_recipe "apache2-windows::_extra_#{extra}"
end

# Start apache service
service 'apache2' do
  service_name "Apache#{node['apache']['windows']['version'].split('.')[0..1].join('.')}"
  action [:enable, :start]
end
