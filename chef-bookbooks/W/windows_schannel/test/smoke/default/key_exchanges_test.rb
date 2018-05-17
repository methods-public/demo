control 'SCHANNEL : KeyExchange : Diffie-Hellman' do
  title 'it should create a registry key and enable the key exchange'
  key = registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman')
  describe key do
    its('Enabled') { should eq -1 }
  end
end
