#
# Cookbook Name:: pdepend
# Recipe:: phar
#
# Copyright (c) 2016, David Joos
#

remote_file "#{node['pdepend']['install_dir']}/pdepend" do
  source node['pdepend']['phar_url']
  mode 0755
end
