#
# Cookbook Name:: wordpress_windows
# Recipe:: plugin_smtpplugin
#
# Copyright 2013, Opscode, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Download & Extract Configure SMTP Plugin
remote_file "#{Chef::Config[:file_cache_path]}/#{node['wordpress']['windows']['plugins']['smtpplugin']['name']}.zip" do
  source "#{node['wordpress']['windows']['plugins']['smtpplugin']['sourcepath']}"
end

windows_zipfile "#{node['wordpress']['windows']['plugins']['path']}" do
  source "#{Chef::Config[:file_cache_path]}\\#{node['wordpress']['windows']['plugins']['smtpplugin']['name']}.zip"
  not_if { ::File.directory?("#{node['wordpress']['windows']['plugins']['path']}\\#{node['wordpress']['windows']['plugins']['smtpplugin']['name']}") }
  action :unzip
end

activate_file="#{node['wordpress']['windows']['plugins']['path']}\\#{node['wordpress']['windows']['plugins']['smtpplugin']['name']}.activated"
file "#{activate_file}" do
  action :nothing
end

execute "doPluginEnable_#{node['wordpress']['windows']['plugins']['smtpplugin']['name']}" do
  cwd "#{node['wordpress']['windows']['path']['admin']}"
  command "#{node['php']['windows']['path']}\\php wp_enable_plugins.php #{node['wordpress']['windows']['plugins']['smtpplugin']['scriptname']}"
  notifies :create, "file[#{activate_file}]", :immediately 
  not_if { ::File.exists?("#{activate_file}")}
end