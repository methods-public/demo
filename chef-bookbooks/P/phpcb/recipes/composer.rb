#
# Cookbook Name:: phpcb
# Recipe:: composer
#
# Copyright (c) 2016, David Joos
#

include_recipe 'composer'

phpcb_dir = "#{Chef::Config[:file_cache_path]}/phpcb"

directory phpcb_dir do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# figure out what version to install
version = if node['phpcb']['version'] != 'latest'
            node['phpcb']['version']
          else
            '*.*.*'
          end

# composer.json
template "#{phpcb_dir}/composer.json" do
  source 'composer.json.erb'
  owner 'root'
  group 'root'
  mode 0600
  variables(
    :version => version,
    :bindir => node['phpcb']['prefix']
  )
end

# composer update
execute 'phpcb-composer' do
  user 'root'
  cwd phpcb_dir
  command 'composer update'
  action :run
end
