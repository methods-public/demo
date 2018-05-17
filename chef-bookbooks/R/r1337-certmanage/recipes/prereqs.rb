#
# Cookbook Name:: r1337-certmanage
# Recipe:: prereqs
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe will configure the base requirements for Route 1337 style SSL certificate management

case node['platform']
  when 'ubuntu', 'centos'

    # Make sure that the directories we rely on exist and have the proper permissions
    directory '/data' do
      owner 'root'
      group 'root'
      mode '755'
    end

    directory '/data/ssl' do
      owner 'root'
      group 'root'
      mode '750'
    end

    directory '/data/ssl/certs' do
      owner 'root'
      group 'root'
      mode '750'
    end

    directory '/data/ssl/keys' do
      owner 'root'
      group 'root'
      mode '750'
    end

  else
    # Do nothing
end
# /data/ssl/certs|keys
# /data 755 roo:root
# /data/ssl 750 root:root
# /data/ssl/certs 750 root:root
# /data/ssl/keys 750 root:root