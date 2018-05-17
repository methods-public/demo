# Default Attribute
default['AWS_ms_dotnet']['source'] = 'http://sdk-for-net.amazonwebservices.com/latest/AWSToolsAndSDKForNet.msi'

default['AWS_ms_dotnet']['install_log'] = File.join(Chef::Config[:file_cache_path], "AWSToolsNet_install.log")
default['AWS_ms_dotnet']['install_options'] = "/qn /quiet /norestart /log #{node['AWS_ms_dotnet']['install_log']}"

#Registry key info
default['AWS_ms_dotnet']['package_regkey'] = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{E55E573E-1003-40C1-9823-E2E77E0E17BC}'
default['AWS_ms_dotnet']['package_regkey_version'] = '3.7.574.0'
default['AWS_ms_dotnet']['package_regkey_name'] = 'DisplayVersion'

#Derrived attributes
default['AWS_ms_dotnet']['executable_location'] = File.join(Chef::Config[:file_cache_path],"#{node['AWS_ms_dotnet']['file_name']}").gsub("/","\\")