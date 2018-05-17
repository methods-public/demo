#
# Cookbook Name:: phpmd
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

case node['phpmd']['install_method']
when 'pear'
  include_recipe 'phpmd::pear'
when 'composer'
  include_recipe 'phpmd::composer'
when 'phar'
  include_recipe 'phpmd::phar'
end
