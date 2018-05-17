control 'SCHANNEL : Hashes : MD5 ' do
  title 'it should create a registry key and enable the hash'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5')
  describe key do
    its('Enabled') { should eq -1 }
  end
end

control 'SCHANNEL : Hashes : SHA ' do
  title 'it should create a registry key and enable the hash'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA')
  describe key do
    its('Enabled') { should eq -1 }
  end
end
