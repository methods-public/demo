#
# Cookbook Name:: phpmd
# Recipe:: composer
#
# Copyright (c) 2016, David Joos
#

include_recipe 'composer'
include_recipe 'pdepend::composer'

phpmd_dir = "#{Chef::Config[:file_cache_path]}/phpmd"

directory phpmd_dir do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# figure out what version to install
version = if node['phpmd']['version'] != 'latest'
            node['phpmd']['version']
          else
            '*.*.*'
          end

# composer.json
template "#{phpmd_dir}/composer.json" do
  source 'composer.json.erb'
  owner 'root'
  group 'root'
  mode 0600
  variables(
    :version => version,
    :bindir => node['phpmd']['prefix']
  )
end

# composer update
execute 'phpmd-composer' do
  user 'root'
  cwd phpmd_dir
  command 'composer update'
  action :run
end
