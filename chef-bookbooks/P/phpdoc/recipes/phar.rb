#
# Cookbook Name:: phpdoc
# Recipe:: phar
#
# Copyright (c) 2016, David Joos
#

remote_file "#{node['phpdoc']['install_dir']}/phpdoc" do
  source node['phpdoc']['phar_url']
  mode 0755
end
