#
# Cookbook Name:: php-windows
# Recipe:: default
#
# Copyright 2013, Opscode, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Include the Apache recipe
include_recipe 'apache2-windows'

# Create PHP directory
directory "#{node['php']['windows']['drive']}\\#{node['php']['windows']['directory']}" do
  action :create
end

# Unzip PHP 
windows_zipfile "#{node['php']['windows']['drive']}/#{node['php']['windows']['directory']}" do
  source node['php']['windows']['source']
  checksum node['php']['windows']['checksum']
  action :unzip
  not_if {::File.exists?("#{node['php']['windows']['drive']}/#{node['php']['windows']['directory']}/php.exe")}
end

# Create php.ini from template
template "#{node['php']['windows']['drive']}/#{node['php']['windows']['directory']}/php.ini" do
  action :create
  notifies :restart, "service[Apache2.2]", :delayed
  variables({
    :database_extensions => node['php']['extension']['init']
  })
end

# Create php.conf for Apache from template
template "#{node['apache2']['windows']['confd']}\\php.conf".gsub('/','\\') do 
  action :create
  notifies :restart, "service[Apache2.2]", :delayed
end

# Add PHP directory to system path
windows_path "#{node['php']['windows']['path']}" do
  action :add
end

# Add PHP extension directory to system path
windows_path "#{node['php']['windows']['path']}\\ext" do
  action :add
end





