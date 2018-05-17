#
# Cookbook Name:: gnugpg
# Recipe:: _cent_install
#
# Copyright (c) 2017 Rodel M. Talampas, All Rights Reserved.

directory '/opt/gnugpg' do
  owner 'root'
  group 'root'
  action :create
end
