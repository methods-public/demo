#
# Cookbook Name:: pdepend
# Recipe:: pear
#
# Copyright (c) 2016, David Joos
#

include_recipe 'php'

pdepend_prerequisite_packages.each do |pkg|
  package pkg do
    action :install
  end
end

# PHP Extension and Application Repository PEAR channel
php_pear_channel 'pear.php.net' do
  action :update
end

# upgrade PEAR
php_pear 'PEAR' do
  action :upgrade
end

# pdepend PEAR channel
pearhub_chan = php_pear_channel 'pear.pdepend.org' do
  action :discover
end

# install/upgrade pdepend
package = 'PHP_Depend'

# upgrade when package is installed and latest version is required
action = if !`pear list | grep #{package}`.empty? && node['pdepend']['version'] == 'latest'
           :upgrade
         else
           :install
         end

php_pear package do
  channel pearhub_chan.channel_name
  version node['pdepend']['version'] if node['pdepend']['version'] != 'latest'
  action action
end
