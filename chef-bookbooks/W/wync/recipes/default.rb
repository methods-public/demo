#
# Cookbook Name:: wync
# Recipe:: default
#
# Copyright (C) 2015 Rilindo Foster
#

remote_file "#{Chef::Config[:file_cache_path]}/#{node['wync']['pkg']}" do
  source node['wync']['download_url']
end

case node["platform"]
when "ubuntu", "debian"
  dpkg_package 'wync' do
    source "#{Chef::Config[:file_cache_path]}/#{node['wync']['pkg']}"
    action :install
  end
when "redhat", "amazon", "scientific", "centos", "suse"  
  yum_package 'wync' do
    source "#{Chef::Config[:file_cache_path]}/#{node['wync']['pkg']}"
    action :install
  end
else
  log "Unknown OS"
end
