#
# Author:: Daptiv Engineering (<dl_teamengineering@daptiv.com>)
# Cookbook Name:: vmware_workstation
# Attribute:: default
#
# Copyright (c) 2014 Daptiv Solutions LLC.
#
# All rights reserved - Do Not Redistribute
#

default[:vmware_workstation][:accept_eula] = true
default[:vmware_workstation][:serial_number] = nil
default[:vmware_workstation][:source_prefix] = nil

case node[:platform]
when 'debian', 'ubuntu'
  default[:vmware_workstation][:install_file] =
    'VMware-Workstation-Full-10.0.2-1744117.x86_64.bundle'
  default[:vmware_workstation][:checksum] = 'f32b72ecfc8b808731e97c3d478a1cda78427aaf'
when 'windows'
  default[:vmware_workstation][:install_file] = 'VMware-workstation-full-10.0.2-1744117.exe'
  default[:vmware_workstation][:checksum] = 'f7826612ceccadf2f6b09b24305c16c32865e48e'
end
