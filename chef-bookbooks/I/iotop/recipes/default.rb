#
# Cookbook:: iotop
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'git::default'

git_client 'default' do
  action :install
end

if node['platform'] == "fedora"
  package 'python'
end
git '/tmp/iotop' do
  repository node['iotop']['url']
  notifies :run, 'execute[install from src]', :immediately
  action :checkout
end

execute 'install from src' do
  command './setup.py install'
  cwd '/tmp/iotop'
  notifies :delete, 'directory[/tmp/iotop]', :immediately
  action :nothing
end

directory '/tmp/iotop' do
  action :nothing
  recursive true
end
