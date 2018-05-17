#
# Cookbook Name:: phpdcd
# Recipe:: phar
#
# Copyright (c) 2016, David Joos
#

remote_file "#{node['phpdcd']['install_dir']}/phpdcd" do
  source node['phpdcd']['phar_url']
  mode 0755
end
