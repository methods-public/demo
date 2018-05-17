#
# Cookbook Name:: phploc
# Recipe:: phar
#
# Copyright (c) 2016, David Joos
#

remote_file "#{node['phploc']['install_dir']}/phploc" do
  source node['phploc']['phar_url']
  mode 0755
end
