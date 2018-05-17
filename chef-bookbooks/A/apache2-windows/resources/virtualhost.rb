#
# Author:: Julian C. Dunn (<jdunn@chef.io>)
# Cookbook Name:: apache2-windows
# Resource:: virtualhost
#
# Copyright:: 2013-2017, Chef Software, Inc.
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

property :server_name, String, name_property: true
property :server_aliases, [Array, String]
property :server_port, Integer, default: 80, required: true
property :docroot, String, required: true
property :directory_options, Array, default: ['FollowSymLinks']
property :allow_overrides, Array, default: ['None']
property :loglevel, String, equal_to: %w(emerg alert crit error warn notice info debug), default: 'info', required: true
property :directory_index, [Array, String], default: 'index.html'
property :template_cookbook, String, default: 'apache2-windows'

action :create do
  template "#{node['apache']['windows']['extra']['vhosts']['dir']}/#{new_resource.server_name}.conf" do
    source new_resource.template_name
    cookbook new_resource.template_cookbook
    variables(
      server_name: new_resource.server_name,
      server_aliases: new_resource.server_aliases,
      server_port: new_resource.server_port,
      docroot: new_resource.docroot,
      directory_options: new_resource.directory_options,
      allow_overrides: new_resource.allow_overrides,
      loglevel: new_resource.loglevel,
      directory_index: new_resource.directory_index
    )
    action :create
    notifies :restart, 'service[apache2]'
  end
end

action :delete do
  file "#{node['apache']['windows']['extra']['vhosts']['dir']}/#{new_resource.server_name}.conf" do
    action :delete
    notifies :restart, 'service[apache2]'
  end
end
