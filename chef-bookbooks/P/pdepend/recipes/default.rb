#
# Cookbook Name:: pdepend
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

case node['pdepend']['install_method']
when 'pear'
  include_recipe 'pdepend::pear'
when 'composer'
  include_recipe 'pdepend::composer'
when 'phar'
  include_recipe 'pdepend::phar'
end
