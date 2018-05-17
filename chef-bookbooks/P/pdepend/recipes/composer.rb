#
# Cookbook Name:: pdepend
# Recipe:: composer
#
# Copyright (c) 2016, David Joos
#

include_recipe 'composer'

pdepend_dir = "#{Chef::Config[:file_cache_path]}/pdepend"

directory pdepend_dir do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# figure out what version to install
version = if node['pdepend']['version'] != 'latest'
            node['pdepend']['version']
          else
            '*.*.*'
          end

# composer.json
template "#{pdepend_dir}/composer.json" do
  source 'composer.json.erb'
  owner 'root'
  group 'root'
  mode 0600
  variables(
    :version => version,
    :bindir => node['pdepend']['prefix']
  )
end

# composer update
execute 'pdepend-composer' do
  user 'root'
  cwd pdepend_dir
  command 'composer update'
  action :run
end
