#
# Cookbook Name:: phpcpd
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

case node['phpcpd']['install_method']
when 'composer'
  include_recipe 'phpcpd::composer'
when 'phar'
  include_recipe 'phpcpd::phar'
end
