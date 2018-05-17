control 'SCHANNEL : Protocols : PCT 1.0 ' do
  title 'it should create a registry key and disable the protocol'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Server')
  describe key do
    its('Enabled') { should eq 0 }
    its('DisabledByDefault') { should eq 1 }
  end
end

control 'SCHANNEL : Protocols : SSL 2.0 ' do
  title 'it should create a registry key and disable the protocol'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server')
  describe key do
    its('Enabled') { should eq 0 }
    its('DisabledByDefault') { should eq 1 }
  end
end

control 'SCHANNEL : Protocols : SSL 3.0 ' do
  title 'it should create a registry key and disable the protocol'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server')
  describe key do
    its('Enabled') { should eq 0 }
    its('DisabledByDefault') { should eq 1 }
  end
end

control 'SCHANNEL : Protocols : TLS 1.0 ' do
  title 'it should create a registry key and enable the protocol'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server')
  describe key do
    # -1 seem to match 0xffffffff ? will raise a issue to check
    its('Enabled') { should eq -1 }
    its('DisabledByDefault') { should eq 0 }
  end
end

control 'SCHANNEL : Protocols : TLS 1.1 ' do
  title 'it should create a registry key and enable the protocol'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server')
  describe key do
    # -1 seem to match 0xffffffff ? will raise a issue to check
    its('Enabled') { should eq -1 }
    its('DisabledByDefault') { should eq 0 }
  end
end

control 'SCHANNEL : Protocols : TLS 1.2 ' do
  title 'it should create a registry key and enable the protocol'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server')
  describe key do
    # -1 seem to match 0xffffffff ? will raise a issue to check
    its('Enabled') { should eq -1 }
    its('DisabledByDefault') { should eq 0 }
  end
end
