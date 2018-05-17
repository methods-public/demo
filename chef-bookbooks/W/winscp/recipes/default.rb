#
# Cookbook Name:: winscp
# Recipe:: default
#
# Copyright 2015, Schuberg Philis
#
# All rights reserved - Do Not Redistribute
#

windows_package node['winscp']['package_name'] do
  source node['winscp']['url']
  options "/DIR=\"#{node['winscp']['install_path']}\" /VERYSILENT /NORESTART"
  installer_type :custom
  action :install
  not_if do
   File.exists?("#{node['winscp']['install_path']}")
  end
end