#
# Cookbook Name:: windows_schannel
# Recipe:: protocols
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
case node['platform']
when 'windows'
  if node['platform_version'].to_f >= 6.0 || node['platform_version'].to_f <= 6.3

    reboot 'computer' do
      action :nothing
      delay_mins 1
      reason 'chef - windows_schannel - Changes made Schannel Protocols requires a reboot to take affect.'
      only_if { node['windows_schannel']['allow_reboot'] == true }
    end

    registry_key 'pct_v1.0' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Server'
      recursive true
      case node['windows_schannel']['pct_v1.0']
      when 'disable'
        values [{ name: 'Enabled', type: :dword, data: 0 },
                { name: 'DisabledByDefault', type: :dword, data: 1 }]
        :create
      when 'enable'
        values [{ name: 'Enabled', type: :dword, data: 4_294_967_295 },
                { name: 'DisabledByDefault', type: :dword, data: 0 }]
        :create
      end
      notifies :request_reboot, 'reboot[computer]'
    end

    registry_key 'ssl_v2.0' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server'
      recursive true
      case node['windows_schannel']['ssl_v2.0']
      when 'disable'
        values [{ name: 'Enabled', type: :dword, data: 0 },
                { name: 'DisabledByDefault', type: :dword, data: 1 }]
        :create
      when 'enable'
        values [{ name: 'Enabled', type: :dword, data: 4_294_967_295 },
                { name: 'DisabledByDefault', type: :dword, data: 0 }]
        :create
      end
      notifies :request_reboot, 'reboot[computer]'
    end

    registry_key 'ssl_v3.0' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server'
      recursive true
      case node['windows_schannel']['ssl_v3.0']
      when 'disable'
        values [{ name: 'Enabled', type: :dword, data: 0 },
                { name: 'DisabledByDefault', type: :dword, data: 1 }]
        :create
      when 'enable'
        values [{ name: 'Enabled', type: :dword, data: 4_294_967_295 },
                { name: 'DisabledByDefault', type: :dword, data: 0 }]
        :create
      end
      notifies :request_reboot, 'reboot[computer]'
    end

    registry_key 'tls_v1.0' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server'
      recursive true
      case node['windows_schannel']['tls_v1.0']
      when 'disable'
        values [{ name: 'Enabled', type: :dword, data: 0 },
                { name: 'DisabledByDefault', type: :dword, data: 1 }]
        :create
      when 'enable'
        values [{ name: 'Enabled', type: :dword, data: 4_294_967_295 },
                { name: 'DisabledByDefault', type: :dword, data: 0 }]
        :create
      end
      notifies :request_reboot, 'reboot[computer]'
    end

    registry_key 'tls_v1.1' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server'
      recursive true
      case node['windows_schannel']['tls_v1.1']
      when 'disable'
        values [{ name: 'Enabled', type: :dword, data: 0 },
                { name: 'DisabledByDefault', type: :dword, data: 1 }]
        :create
      when 'enable'
        values [{ name: 'Enabled', type: :dword, data: 4_294_967_295 },
                { name: 'DisabledByDefault', type: :dword, data: 0 }]
        :create
      end
      notifies :request_reboot, 'reboot[computer]'
    end

    registry_key 'tls_v1.2' do
      key 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
      recursive true
      case node['windows_schannel']['tls_v1.2']
      when 'disable'
        values [{ name: 'Enabled', type: :dword, data: 0 },
                { name: 'DisabledByDefault', type: :dword, data: 1 }]
        :create
      when 'enable'
        values [{ name: 'Enabled', type: :dword, data: 4_294_967_295 },
                { name: 'DisabledByDefault', type: :dword, data: 0 }]
        :create
      end
      notifies :request_reboot, 'reboot[computer]'
    end
  end
end
