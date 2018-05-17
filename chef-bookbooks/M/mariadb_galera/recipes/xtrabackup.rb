#
# Cookbook Name:: mariadb_galera
# Recipe:: xtrabackup
#
# Copyright (c) 2016 Robert Ressl, All Rights Reserved.

package 'socat' do
  action :install
end

package 'percona-xtrabackup' do
  action :install
end
