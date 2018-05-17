#
# Cookbook Name:: ufw_install
# Recipe:: default
#
# Copyright 2014, HiganWorks LLC.
#

remote_file File.join(Chef::Config[:file_cache_path], 'ufw-0.33.tar.gz') do
  source 'https://launchpad.net/ufw/0.33/0.33/+download/ufw-0.33.tar.gz'
end

bash 'install_ufw' do
  action :run
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
  tar xzf ufw-0.33.tar.gz
  cd ufw-0.33
  python ./setup.py install
  EOH
  creates '/usr/bin/ufw'
  notifies :run, 'execute[remove_write_permission_for_ufw]'
end

execute 'remove_write_permission_for_ufw' do
  action :nothing
  command 'chmod -R g-w /etc/ufw /usr/sbin/ufw /lib/ufw/ufw-init /etc/default/ufw'
end
