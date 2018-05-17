#
# Cookbook Name:: phpcpd
# Recipe:: phar
#
# Copyright (c) 2016, David Joos
#

remote_file "#{node['phpcpd']['install_dir']}/phpcpd" do
  source node['phpcpd']['phar_url']
  mode 0755
end
