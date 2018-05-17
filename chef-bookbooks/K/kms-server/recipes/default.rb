# This cookbook does nothing on non-windows platform
return unless platform? 'windows'

ruby_block 'Ensure kms host key is provided' do
  block { raise 'node[:kms_server][:host_key] is mandatory to setup Volume Activation service' }
  only_if { node['kms_server'].nil? || node['kms_server']['host_key'].nil? }
end

# Enable KMS service
windows_feature 'VolumeActivation-Full-Role'

# Configure the service
registry_key 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform' do
  values [
    # Disables publishing of the KMS Host to the DNS Service
    { type: :dword, name: 'DisableDnsPublishing', data: node['kms_server']['disable_dns_publishing'] ? 1 : 0 },
    # Defines the domain list used for DNS publishing of the KMS Host entry
    { type: :multi_string, name: 'DnsDomainPublishList', data: node['kms_server']['dns_publishing_domains'] },
    # Reduces process priority assigned to KMS service
    { type: :dword, name: 'EnableKmsLowPriority', data: node['kms_server']['reduce_kms_priority'] ? 1 : 0 },
    # Defines KMS TCP listening port.
    { type: :string, name: 'KeyManagementServiceListeningPort', data: node['kms_server']['listening_port'] },
    # Defines the activation interval.
    { type: :dword, name: 'VLActivationInterval', data: node['kms_server']['activation_interval'] },
    # Defines the renewal interval.
    { type: :dword, name: 'VLRenewalInterval', data: node['kms_server']['renewal_interval'] },
  ]
  notifies :stop, 'service[sppsvc]', :before
  recursive true
end

# Setup the KMS Host Key and activate it
batch 'Register and activate KMS key' do
  code <<-EOH
cscript.exe slmgr.vbs /ipk #{node['kms_server']['host_key']}"
cscript.exe slmgr.vbs /ato
  EOH
  cwd 'C:\Windows\System32'
  sensitive true
  # http://msdn.microsoft.com/en-us/library/cc534596%28v=vs.85%29.aspx
  not_if do
    require 'wmi-lite'
    licenses = ::WmiLite::Wmi.new.instances_of('SoftwareLicensingProduct')
    licenses.any? { |e| e['LicenseStatus'] == 1 && e['ProductKeyChannel'] == 'Volume:CSVLK' && node['kms_server']['host_key'].end_with?(e['PartialProductKey']) }
  end
  notifies :stop, 'service[sppsvc]', :before
end

service 'sppsvc' do
  action :start
end
