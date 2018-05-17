#
# Cookbook Name:: staticip
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

if node['staticip']['ipaddress'] == '127.0.0.1'
  Chef::Log.warn "Attribute of node['staticip']['ipaddress'] is required"
end

# TODO: to be implemented
Chef::Log.warn('TO be implemented soon.')
