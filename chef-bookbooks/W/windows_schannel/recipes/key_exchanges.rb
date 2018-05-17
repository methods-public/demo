#
# Cookbook Name:: windows_schannel
# Recipe:: keyExchanges
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
case node['platform']
when 'windows'
  if node['platform_version'].to_f >= 6.0 || node['platform_version'].to_f <= 6.3
    registry_key 'keyEx_dh' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman'
      recursive true
      case node['windows_schannel']['keyEx_dh']
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
