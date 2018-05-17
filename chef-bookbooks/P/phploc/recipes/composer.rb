#
# Cookbook Name:: phploc
# Recipe:: composer
#
# Copyright (c) 2016, David Joos
#

include_recipe 'composer'

phploc_dir = "#{Chef::Config[:file_cache_path]}/phploc"

directory phploc_dir do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# figure out what version to install
version = if node['phploc']['version'] != 'latest'
            node['phploc']['version']
          else
            '*.*.*'
          end

# composer.json
template "#{phploc_dir}/composer.json" do
  source 'composer.json.erb'
  owner 'root'
  group 'root'
  mode 0600
  variables(
    :version => version,
    :bindir => node['phploc']['prefix']
  )
end

# composer update
execute 'phploc-composer' do
  user 'root'
  cwd phploc_dir
  command 'composer update'
  action :run
end
