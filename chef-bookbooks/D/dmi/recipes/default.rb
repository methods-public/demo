#
# Cookbook Name:: dmi
# Recipe:: default
#
# Copyright 2017, Criteo
#
# All rights reserved - Do Not Redistribute
#

ohai 'reload_dmi' do
  plugin 'dmi'
  action :nothing
end

case node['platform_family']
when 'windows'
  windows_package node['dmi']['package']['name'] do
    source node['dmi']['package']['url']
    checksum node['dmi']['package']['sha256sum']
    installer_type :inno
    options '/SILENT'
  end

  # https://github.com/opscode-cookbooks/git/pull/19/files
  ENV['PATH'] += ";#{node['dmi']['path']}"
  windows_path node['dmi']['path'] do
    action :add
    notifies :reload, 'ohai[reload_dmi]', :immediately
  end
when 'rhel', 'debian'
  package 'dmidecode' do
    notifies :reload, 'ohai[reload_dmi]', :immediately
  end
end
