#
# Author:: Daptiv Engineering (<dl_teamengineering@daptiv.com>)
# Cookbook Name:: vmware_workstation
# Recipe:: default
#
# Copyright (c) 2014 Daptiv Solutions LLC.
#
# All rights reserved - Do Not Redistribute
#

if node[:platform] == 'ubuntu'
  include_recipe 'vmware_workstation::ubuntu'
elsif node[:platform] == 'windows'
  include_recipe 'vmware_workstation::windows'
end
