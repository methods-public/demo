#
# Cookbook Name:: elastic_beats_repo
# Recipe:: default
#
# Copyright 2017, Virender Khatri
#

case node['platform_family']
when 'debian'
  include_recipe 'elastic_beats_repo::apt'
when 'fedora', 'rhel', 'amazon'
  include_recipe 'elastic_beats_repo::yum'
else
  raise "platform_family #{node['platform_family']} not supported"
end
