# Encoding: utf-8

#
# Cookbook Name:: .
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'phantomjs'

package 'unzip' do
  action :install
end

directory node[:yslow][:install_dir] do
  recursive true
  action :create
end

zip_path = "#{Chef::Config[:file_cache_path]}/yslow.zip"
src_url = "#{node[:yslow][:base_url]}/yslow-phantomjs-#{node[:yslow][:version]}.zip"

remote_file zip_path do
  source src_url
  checksum node[:yslow][:checksum]
  action :create_if_missing
end

execute 'unzip yslow' do
  command "unzip #{zip_path} -d #{node[:yslow][:install_dir]}"
  action :run
end
