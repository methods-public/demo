#
# Cookbook Name:: virtualbox-guest-additions
# Attributes:: default
#
# Copyright (C) 2014 Patrick Ayoup
#
# MIT License
#


default[:virtualbox_guest_additions][:virtualbox_version] = '4.3.12'
default[:virtualbox_guest_additions][:iso_uri] = "http://download.virtualbox.org/virtualbox/#{node[:virtualbox_guest_additions][:virtualbox_version]}/VBoxGuestAdditions_#{node[:virtualbox_guest_additions][:virtualbox_version]}.iso"
default[:virtualbox_guest_additions][:packages] = %W[make gcc kernel-devel kernel-headers dkms]
default[:virtualbox_guest_additions][:device_path] = "#{Chef::Config[:file_cache_path]}/vboxAdditions.iso"
default[:virtualbox_guest_additions][:mount_point] = '/mnt/vboxAdditions'

# KERN_DIR=/usr/src/kernels/`uname -r`
# export KERN_DIR