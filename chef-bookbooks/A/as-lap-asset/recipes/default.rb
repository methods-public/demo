#
# Cookbook Name:: as_lap_asset
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'as-apache2::default'
include_recipe 'as-php::default'
include_recipe 'as-asset::default'

# download composer
execute 'composer-install' do
  command 'curl -sS https://getcomposer.org/installer | php ;mv composer.phar /usr/local/bin/composer'
  not_if { ::File.exists?('/usr/local/bin/composer') }
end
