#
# Cookbook Name:: mariadb_galera
# Recipe:: package
#
# Copyright (c) 2016 Robert Ressl, All Rights Reserved.

package 'which' do
  action :install
end

package 'MariaDB-server' do
  action :install
end
