#
# Cookbook Name:: dante_ng
# Recipe:: install
#
# Copyright 2018, Alexander Merkulov
#

node['dante_ng']['packages'].each do |p|
  package p
end

remote_file "#{Chef::Config[:file_cache_path]}/dante-#{node['dante_ng']['version']}.tar.gz" do
  source   node['dante_ng']['url']
  checksum node['dante_ng']['checksum']
  action   :create
  notifies :run, 'bash[compile_dante_from_source]', :immediately
end

bash 'compile_dante_from_source' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xvf dante-#{node['dante_ng']['version']}.tar.gz
    cd dante-#{node['dante_ng']['version']}
    ./configure
    make && make install
  EOH
  action :nothing
end

