#
# Cookbook Name:: windows_schannel
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
case node['platform']
when 'windows'
  if node['platform_version'].to_f >= 6.0 || node['platform_version'].to_f <= 6.3
    # Windows Version 6.0 is Windows 2008 RTM
    # Windows Version 6.3 is Windows 2012 R2
    include_recipe 'windows_schannel::protocols'
    include_recipe 'windows_schannel::ciphers'
    include_recipe 'windows_schannel::hashes'
    include_recipe 'windows_schannel::key_exchanges'
  end
end
