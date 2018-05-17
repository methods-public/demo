#
# Cookbook Name:: phploc
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

case node['phploc']['install_method']
when 'composer'
  include_recipe 'phploc::composer'
when 'phar'
  include_recipe 'phploc::phar'
end
