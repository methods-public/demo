#
# Cookbook Name:: chef_mariadb_galera
# Recipe:: repository
#
# Copyright (c) 2016 Robert Ressl, All Rights Reserved.

yum_repository 'mariadb' do
  description 'MariaDB Repo'
  baseurl node['mariadb_galera']['repo']['url']['mariadb']
  gpgkey node['mariadb_galera']['repo']['gpgkey']['mariadb']
  gpgcheck true
  action :create
end
