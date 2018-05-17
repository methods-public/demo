#
# Author:: Daptiv Engineering (<dl_teamengineering@daptiv.com>)
# Cookbook Name:: vmware_workstation
# Recipe:: windows
#
# Copyright (c) 2014 Daptiv Solutions LLC.
#
# All rights reserved - Do Not Redistribute
#

windows_package 'VMware Workstation' do
  source "#{node[:vmware_workstation][:source_prefix]}/#{node[:vmware_workstation][:install_file]}"
  checksum node[:vmware_workstation][:checksum]
  version '10.0.2'
  options " /s /nsr /v EULAS_AGREED=1 SERIALNUMBER=\"#{node[:vmware_workstation][:serial_number]}\""
  only_if { node[:vmware_workstation][:accept_eula] }
  action :install
end
