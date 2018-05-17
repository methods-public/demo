#
# Cookbook Name:: babushka
# Recipe:: default
#
# Copyright (C) 2014 Jose Luis Salas
#
# MIT License
#

include_recipe 'git::default'

git node['babushka']['git']['clone_path'] do
  repository node['babushka']['git']['repo_path']
  action node['babushka']['git']['update_strategy']
  revision node['babushka']['git']['revision']
end

babushka_bin = File.join(node['babushka']['git']['clone_path'], 'bin', 'babushka.rb')

link '/usr/local/bin/babushka' do
  to babushka_bin
end
