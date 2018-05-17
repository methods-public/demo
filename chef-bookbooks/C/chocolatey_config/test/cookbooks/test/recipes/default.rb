include_recipe 'chocolatey::default'

# this is really a bug in the chocolatey cookbook
windows_path 'C:\ProgramData\chocolatey\bin'

chocolatey_config 'Set the Chocolatey config path' do
  config_key 'cacheLocation'
  value 'c:\temp\choco'
end

chocolatey_config 'BogusConfig' do
  action :unset
end
