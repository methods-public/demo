control 'SCHANNEL : Ciphers : null ' do
  title 'it should create a registry key and disable the cipher'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL')
  describe key do
    its('Enabled') { should eq 0 }
  end
end

control 'SCHANNEL : Ciphers : DES' do
  title 'it should create a registry key and disable the cipher'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56') do
    its('Enabled') { should eq 0 }
  end
end

control 'SCHANNEL : Ciphers : RC2' do
  title 'it should create a registry key and disable the cipher'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128') do
    its('Enabled') { should eq 0 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128') do
    its('Enabled') { should eq 0 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128') do
    its('Enabled') { should eq 0 }
  end
end

control 'SCHANNEL : Ciphers : RC4' do
  title 'it should create a registry key and disable the cipher'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128') do
    its('Enabled') { should eq 0 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128') do
    its('Enabled') { should eq 0 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128') do
    its('Enabled') { should eq 0 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128') do
    its('Enabled') { should eq 0 }
  end
end

control 'SCHANNEL : Ciphers : 3DES' do
  title 'it should create a registry key and disable the cipher'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168') do
    its('Enabled') { should eq -1 }
  end
end

control 'SCHANNEL : Ciphers : AES' do
  title 'it should create a registry key and disable the cipher'
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 128/128') do
    its('Enabled') { should eq -1 }
  end
  describe registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 256/256') do
    its('Enabled') { should eq -1 }
  end
end
