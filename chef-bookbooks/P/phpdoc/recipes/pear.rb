#
# Cookbook Name:: phpdoc
# Recipe:: pear
#
# Copyright (c) 2016, David Joos
#

include_recipe 'php'

# PHP Extension and Application Repository PEAR channel
pearhub_chan = php_pear_channel 'pear.php.net' do
  action :update
end

# upgrade PEAR
php_pear 'PEAR' do
  channel pearhub_chan.channel_name
  action :upgrade
end

# phpDocumentor PEAR channel
pearhub_chan = php_pear_channel 'pear.phpdoc.org' do
  action :discover
end

# install/upgrade phpDocumentor
package = 'phpDocumentor'

# upgrade when package is installed and latest version is required
action = if !`pear list | grep #{package}`.empty? && node['phpdoc']['version'] == 'latest'
           :upgrade
         else
           :install
         end

php_pear package do
  channel pearhub_chan.channel_name
  version node['phpdoc']['version'] if node['phpdoc']['version'] != 'latest'
  action action
end
