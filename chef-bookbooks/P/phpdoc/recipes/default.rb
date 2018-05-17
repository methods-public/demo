#
# Cookbook Name:: phpdoc
# Recipe:: default
#
# Copyright (c) 2016, David Joos
#

# install XSLTProcessor
package 'php5-xsl' do
  action :upgrade
end

case node['phpdoc']['install_method']
when 'pear'
  include_recipe 'phpdoc::pear'
when 'composer'
  include_recipe 'phpdoc::composer'
when 'phar'
  include_recipe 'phpdoc::phar'
end
