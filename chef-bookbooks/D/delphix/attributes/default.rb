#
# Cookbook Name:: delphix
# Attributes:: default
#
# Copyright:: Copyright (c) 2018 by Delphix. All rights reserved.
#

default['delphix']['user'] = 'delphix'
default['delphix']['group'] = 'delphix'
default['delphix']['mount'] = "/mnt/#{default['delphix']['user']}"
default['delphix']['toolkit'] = "/home/#{default['delphix']['user']}/toolkit"
default['delphix']['ssh']['user'] = ''
default['delphix']['ssh']['key'] = ''
