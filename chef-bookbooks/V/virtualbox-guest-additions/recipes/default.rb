#
# Cookbook Name:: virtualbox-guest-additions
# Recipe:: default
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#

include_recipe "yum-epel"

# Install dependencies
node[:virtualbox_guest_additions][:packages].each do |p|
  package p do
    action :install
  end
end

# Get additions iso file
remote_file "#{Chef::Config[:file_cache_path]}/vboxAdditions.iso" do
  source node[:virtualbox_guest_additions][:iso_uri]
end

# Create the mount point
directory node[:virtualbox_guest_additions][:mount_point] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if { ::File.directory?(node[:virtualbox_guest_additions][:mount_point]) }
end

# mount the iso
mount node[:virtualbox_guest_additions][:mount_point] do
  action [:mount, :enable]
  device node[:virtualbox_guest_additions][:device_path]
  fstype "iso9660"
  options "loop"
  only_if { Dir["#{node[:virtualbox_guest_additions][:mount_point]}/*"].empty? }
end

# The VBoxLinuxAdditions script returns 1 even though it doesn't report any errors
# both in the output and in the logs. After running the script, the additions
# seem to be properly installed anyway... This is the best way to determine if 
# there were any issues with the installation as this is probably a bug.
execute "install vbox guest additions" do
  command "! sh #{node[:virtualbox_guest_additions][:mount_point]}}/VBoxLinuxAdditions.run | grep -E -i 'error|fail'"
end

# unmount the ISO
mount node[:virtualbox_guest_additions][:mount_point] do
  action [:umount]
  device node[:virtualbox_guest_additions][:device_path]
  mounted true
  enabled true
end

# Delete the ISO
file node[:virtualbox_guest_additions][:device_path] do
  action :delete
end

# # Delete the mount point
directory node[:virtualbox_guest_additions][:mount_point] do
  action :delete
end
