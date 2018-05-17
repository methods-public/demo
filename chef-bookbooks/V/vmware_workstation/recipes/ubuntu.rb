#
# Author:: Daptiv Engineering (<dl_teamengineering@daptiv.com>)
# Cookbook Name:: vmware_workstation
# Recipe:: ubuntu
#
# Copyright (c) 2014 Daptiv Solutions LLC.
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:vmware_workstation][:install_file]}" do
  source "#{node[:vmware_workstation][:source_prefix]}/#{node[:vmware_workstation][:install_file]}"
  checksum node[:vmware_workstation][:checksum]
  mode 00644
  action :create_if_missing
end

bash 'VMware Workstation' do
  cwd Chef::Config[:file_cache_path]
  install_params = '--console --eulas-agreed --set-setting vmware-workstation serialNumber'
  install_file = node[:vmware_workstation][:install_file]
  serial_number = node[:vmware_workstation][:serial_number]
  cmd = "sudo su; sh #{install_file} #{install_params} #{serial_number} --required"
  code <<-EOH
    #{cmd}
  EOH
  not_if { File.exist?('/usr/lib/vmware') }
  only_if { node[:vmware_workstation][:accept_eula] }
end
