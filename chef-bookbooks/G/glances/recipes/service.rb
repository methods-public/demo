# -*- coding: utf-8 -*-
#
# Cookbook Name:: glances
# Recipe:: service
#
# Copyright 2015, Sliim
#

include_recipe 'glances'

user 'glances' do
  home '/etc/glances'
  comment 'Glances monitoring'
  manage_home false
  system true
end

template '/etc/default/glances' do
  source 'glances.default.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[glances]', :delayed
end

template '/etc/init.d/glances' do
  source 'init_script.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[glances]', :delayed
end

service 'glances' do
  action [:enable, :start]
  supports status: true, start: true, stop: true, restart: true
end

execute 'systemctl-daemon-reload' do
  action :nothing
  command 'systemctl daemon-reload'
  subscribes :run, 'template[/etc/init.d/glances]', :immediately
  only_if { node['init_package'] == 'systemd' }
end
