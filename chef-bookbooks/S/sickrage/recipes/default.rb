#
# Cookbook Name:: sickrage
# Recipe:: default
#
# Copyright 2015, Jeremy Miller
#
# All rights reserved - Do Not Redistribute
#

# Attibutes
error = ''
if node['platform_version'].to_f >= 7.0
  node.default['sickrage']['release'] = 7
elsif node['platform_version'].to_f >= 6.0
  node.default['sickrage']['release'] = 6
else
  error = 'Please use a supported OS and version'
end
raise error unless error.empty?

# Recipes
if node['sickrage']['release'] == 7
  include_recipe 'sickrage::install_sickrage'
elsif node['sickrage']['release'] == 6
  include_recipe 'sickrage::_install_python'
  include_recipe 'sickrage::install_sickrage'
end
