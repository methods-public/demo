#
# Cookbook Name:: mariadb_galera
# Recipe:: server
#
# Copyright (c) 2016 Robert Ressl, All Rights Reserved.

data_bag = node['mariadb_galera']['data_bag']
secret = data_bag_item(data_bag['name'], data_bag['secret_item'])
cluster_nodes = search(:node, 'role:galera').sort.map { |nodes| nodes['hostname'] }
initiator = search(:node, 'mariadb_galera:initiator').sort.map { |nodes| nodes['hostname'] }.first

template '/etc/my.cnf.d/server.cnf' do
  source 'server.cnf.erb'
  owner 'root'
  group 'mysql'
  mode '0640'
  variables(
    user: node['mariadb_galera']['wsrep']['user'],
    password: secret['password']['wsrep'],
    cluster_address: cluster_nodes
  )
end

template '/root/.my.cnf' do
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables(
    password: secret['password']['root']
  )
  only_if { node['mariadb_galera']['root_autologin'] == true }
end

galera_init initiator do
  action :create
  socket node['mariadb_galera']['socket']
  root_pw secret['password']['root']
  sst_user node['mariadb_galera']['wsrep']['user']
  sst_pw secret['password']['wsrep']
end
