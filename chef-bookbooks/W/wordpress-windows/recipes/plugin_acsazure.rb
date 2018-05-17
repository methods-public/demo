#
# Cookbook Name:: wordpress_windows
# Recipe:: plugin_acsazure
#
# Copyright 2013, Opscode, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Download & Extract ACS Plugin
remote_file "#{Chef::Config[:file_cache_path]}/#{node['wordpress']['windows']['plugins']['acsplugin']['name']}.zip" do
  source "#{node['wordpress']['windows']['plugins']['acsplugin']['sourcepath']}"
end

windows_zipfile "#{node['wordpress']['windows']['plugins']['path']}" do
  source "#{Chef::Config[:file_cache_path]}\\#{node['wordpress']['windows']['plugins']['acsplugin']['name']}.zip"
  not_if { ::File.directory?("#{node['wordpress']['windows']['plugins']['path']}\\#{node['wordpress']['windows']['plugins']['acsplugin']['name']}") }
  action :unzip
end

template ::File.join(node['wordpress']['windows']['plugins']['path'],node['wordpress']['windows']['plugins']['acsplugin']['name'],'acs-wp-plugin-config.php') do
  source "acs-wp-plugin-config.php.erb"
  action :create
  variables(
  :acs_namespace        => node[:azure][:acs][:namespace],
  :acs_realm            => node['wordpress']['windows']['siteurl'],
  :acs_key        => node[:azure][:acs][:key],
  )
end

activate_file="#{node['wordpress']['windows']['plugins']['path']}\\#{node['wordpress']['windows']['plugins']['acsplugin']['name']}.activated"
file "#{activate_file}" do
  action :nothing
end

execute "doPluginEnable_#{node['wordpress']['windows']['plugins']['acsplugin']['name']}" do
  cwd "#{node['wordpress']['windows']['path']['admin']}"
  command "#{node['php']['windows']['path']}\\php wp_enable_plugins.php #{node['wordpress']['windows']['plugins']['acsplugin']['scriptname']}"
  notifies :create, "file[#{activate_file}]", :immediately 
  not_if { ::File.exists?("#{activate_file}")}
end