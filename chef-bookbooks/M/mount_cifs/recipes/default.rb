#
# Cookbook Name:: mount_cifs
# Recipe:: default
#
# Copyright (C) 2014 Ryan Larson
#

case node["platform"]
  when "ubuntu"
    # Run apt-get update
    include_recipe "apt::default"
    if node['platform_version'].to_f <= 10.04
  	  package "smbfs"
    else
  	  package "cifs-utils"
    end

  when "centos"
  	if node['platform_version'].to_f >= 6
  	  package "cifs-utils"
  	else
  	  package "samba-client"
  	end

  when "debian"
  	include_recipe "apt::default"
  	package "cifs-utils"

  when "fedora"
    package "cifs-utils"

  when "oracle"
    package "cifs-utils"
end