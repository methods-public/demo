#
# Cookbook Name:: windows_schannel
# Recipe:: hashes
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
case node['platform']
when 'windows'
  if node['platform_version'].to_f >= 6.0 || node['platform_version'].to_f <= 6.3
    registry_key 'hash_md5' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5'
      recursive true
      case node['windows_schannel']['hash_md5']
      when 'disable'
        values(name: 'Enabled', type: :dword, data: 0)
        :create
      when 'enable'
        values(name: 'Enabled', type: :dword, data: 4_294_967_295)
        :create
      end
    end
    registry_key 'hash_sha' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA'
      recursive true
      case node['windows_schannel']['hash_sha']
      when 'disable'
        values(name: 'Enabled', type: :dword, data: 0)
        :create
      when 'enable'
        values(name: 'Enabled', type: :dword, data: 4_294_967_295)
        :create
      end
    end
  end
end
