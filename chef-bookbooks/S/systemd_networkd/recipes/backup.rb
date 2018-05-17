#
# Cookbook Name:: systemd_networkd
# Recipe:: backup
#
# Copyright 2014, Intel Corp
#
# All rights reserved - Do Not Redistribute
#

createdirs = [ "/opt/chef/embedded/apps/ohai/lib/ohai/plugins/intel" ]
createdirs.each do |dir|
  ### Create networkd dirs if they don't exist ###
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end


cookbook_file "cfgdump.rb" do
  path "/usr/bin/cfgdump"
  action :create
end

cookbook_file "intel_switch.rb" do
  path "/opt/chef/embedded/apps/ohai/lib/ohai/plugins/intel/intel_switch.rb"
  action :create
end
