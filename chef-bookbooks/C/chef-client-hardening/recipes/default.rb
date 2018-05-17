# -*- coding: utf-8 -*-
#
# Cookbook Name:: chef-client-hardening
# Recipe:: default
#
# Copyright 2015, Sliim
#

['/etc/chef', '/var/chef'].each do |dir|
  directory dir do
    mode '0700'
    owner 'root'
    group 'root'
  end

  ::Dir.glob("#{dir}/*").each do |f|
    if ::File.directory?(f)
      directory f do
        mode '0700'
        owner 'root'
        group 'root'
      end
    elsif ::File.file?(f)
      file f do
        mode '0600'
        owner 'root'
        group 'root'
      end
    end
  end
end
