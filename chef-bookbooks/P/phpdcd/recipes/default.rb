#
# Cookbook Name:: phpdcd
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

case node['phpdcd']['install_method']
when 'composer'
  include_recipe 'phpdcd::composer'
when 'phar'
  include_recipe 'phpdcd::phar'
end
