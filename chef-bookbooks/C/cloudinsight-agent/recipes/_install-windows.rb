#
# Cookbook Name:: cloudinsight-agent
# Recipe:: _install-windows
#

cloudinsight_agent_version = node['cloudinsight-agent']['agent_version']

# If no version is specified, select the latest package
cloudinsight_agent_msi = cloudinsight_agent_version ? "ddagent-cli-#{cloudinsight_agent_version}.msi" : 'ddagent-cli.msi'
temp_file = ::File.join(Chef::Config[:file_cache_path], 'ddagent-cli.msi')

# Download the installer to a temp location
remote_file 'MSI installer' do
  path temp_file
  source node['cloudinsight-agent']['windows_agent_url'] + cloudinsight_agent_msi
  # As of v1.37, the windows cookbook doesn't upgrade the package if a newer version is downloaded
  # As a workaround uninstall the package first if a new MSI is downloaded
  notifies :remove, 'windows_package[Cloudinsight Agent]', :immediately
end

# Install the package
windows_package 'Cloudinsight Agent' do
  source temp_file
  options %(LICENSEKEY="#{node['cloudinsight-agent']['license_key']}" HOSTNAME="#{node['hostname']}" TAGS="#{node['tags'].join(',')}")
  action :install
end
