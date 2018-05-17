#
# Cookbook Name:: phpcb
# Recipe:: phar
#
# Copyright (c) 2016, David Joos
#

remote_file "#{node['phpcb']['install_dir']}/phpcb" do
  source node['phpcb']['phar_url']
  mode 0755
end
