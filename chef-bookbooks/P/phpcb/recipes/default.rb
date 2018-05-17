#
# Cookbook Name:: phpcb
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

case node['phpcb']['install_method']
when 'composer'
  include_recipe 'phpcb::composer'
when 'phar'
  include_recipe 'phpcb::phar'
end
