#
# Cookbook Name:: git-extensions
# Recipe:: default
#
# Copyright 2015, Schuberg Philis
#
# All rights reserved - Do Not Redistribute
#

windows_package node['git-extensions']['package_name'] do
  source node['git-extensions']['url']
  options "/quiet"
  action :install
  not_if do
   File.exists?("#{node['git-extensions']['install_path']}\GitExtensions")
  end
end