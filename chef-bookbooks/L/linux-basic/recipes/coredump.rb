#
# Cookbook Name:: linux-basic
# Recipe:: coredump
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

directory '/usr/local/coredump' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end
