#
# Cookbook Name:: mariadb_galera
# Recipe:: service
#
# Copyright (c) 2016 Robert Ressl, All Rights Reserved.

cluster = search(:node, 'role:galera').first['galera']['cluster']

service 'mariadb' do
  cluster ? (action [:enable, :start]) : (action [:disable])
end
