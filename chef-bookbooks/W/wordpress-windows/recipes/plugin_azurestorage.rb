#
# Cookbook Name:: wordpress_windows
# Recipe:: plugin_azurestorage
#
# Copyright 2013, Opscode, Inc.
#
# All rights reserved - Do Not Redistribute
#

require 'rubygems'
chef_gem "mysql"

# Download & Extract Azure Storage Plugin
remote_file "#{Chef::Config[:file_cache_path]}/#{node['wordpress']['windows']['plugins']['azurestorage']['name']}.zip" do
  source "#{node['wordpress']['windows']['plugins']['azurestorage']['sourcepath']}"
end

windows_zipfile "#{node['wordpress']['windows']['plugins']['path']}" do
  source "#{Chef::Config[:file_cache_path]}\\#{node['wordpress']['windows']['plugins']['azurestorage']['name']}.zip"
  not_if { ::File.directory?("#{node['wordpress']['windows']['plugins']['path']}\\#{node['wordpress']['windows']['plugins']['azurestorage']['name']}") }
  action :unzip
end

activate_file="#{node['wordpress']['windows']['plugins']['path']}\\#{node['wordpress']['windows']['plugins']['azurestorage']['name']}.activated"
file "#{activate_file}" do
  action :nothing
end

execute "doPluginEnable_#{node['wordpress']['windows']['plugins']['azurestorage']['name']}" do
  cwd "#{node['wordpress']['windows']['path']['admin']}"
  command "#{node['php']['windows']['path']}\\php wp_enable_plugins.php #{node['wordpress']['windows']['plugins']['azurestorage']['scriptname']}"
  notifies :create, "file[#{activate_file}]", :immediately 
  not_if { ::File.exists?("#{activate_file}")}
end

wordpress_windows_setting "azure_storage_account_name" do
  value "#{node[:azure][:blob][:name]}"
  autoload "yes"
end
wordpress_windows_setting "azure_storage_account_primary_access_key" do
  value "#{node[:azure][:blob][:primary_key]}"
  autoload "yes"
end
wordpress_windows_setting "default_azure_storage_account_container_name" do
  value "#{node[:azure][:blob][:default_container]}"
  autoload "yes"
end
wordpress_windows_setting "cname" do
  value "#{node[:azure][:blob][:dns_cname]}"
  autoload "yes"
end
wordpress_windows_setting "azure_storage_use_for_default_upload" do
  value "1"
  autoload "yes"
end
wordpress_windows_setting "http_proxy_host" do
  value ""
  autoload "yes"
end
wordpress_windows_setting "http_proxy_port" do
  value ""
  autoload "yes"
end
wordpress_windows_setting "http_proxy_username" do
  value ""
  autoload "yes"
end
wordpress_windows_setting "http_proxy_password" do
  value ""
  autoload "yes"
end
wordpress_windows_setting "azure_storage_allow_per_user_settings" do
  value ""
  autoload "yes"
end

