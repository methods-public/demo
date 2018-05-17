# -*- coding: utf-8 -*-
#
# Cookbook Name:: glances
# Recipe:: default
#
# Copyright 2015, Sliim
#

python_runtime '2'

python_package 'glances' do
  version node['glances']['version']
  python '2'
end

node['glances']['extra_pip_packages'].each do |pkg|
  python_package pkg do
    python '2'
  end
end

directory '/etc/glances' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/glances/glances.conf' do
  source 'glances.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
