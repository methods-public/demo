#
# Cookbook Name:: linux-basic
# Recipe:: files
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

node.from_file(run_context.resolve_attribute('linux-basic', 'default'))

directory node['basic']['download_dir'] do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

directory '/var/log/chef/' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end
