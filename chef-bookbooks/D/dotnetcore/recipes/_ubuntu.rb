#
# Cookbook Name:: dotnetcore
# Recipe:: _ubuntu
#
# Copyright (C) 2016 Andrew Cornies
#
# All rights reserved - Do Not Redistribute
#

unless %w(trusty xenial).include? node['lsb']['codename']
  fail 'Only Ubuntu 14.04 (trusty), and 16.04 (xenial), and their dirivatives (Linux Mint) are supported by dotnetcore'
end

include_recipe 'apt::default' do
    only_if { !node.has_recipe?('apt::default') }
end

apt_repository 'dotnetdev' do
    uri node['dotnetcore']['apt_package_source']
    components ['main']
    distribution node['lsb']['codename']
    arch 'amd64'
    key "#{node['dotnetcore']['apt_package_source']}/dists/#{node['lsb']['codename']}/Release.gpg"
end

package node['dotnetcore']['package']['name'] do
    options '--force-yes'
end
