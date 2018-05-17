#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: _install-windows
#

oneapm_ci_agent_version = node['oneapm-ci-agent']['agent_version']

# If no version is specified, select the latest package
oneapm_ci_agent_msi = oneapm_ci_agent_version ? "ddagent-cli-#{oneapm_ci_agent_version}.msi" : 'ddagent-cli.msi'
temp_file = ::File.join(Chef::Config[:file_cache_path], 'ddagent-cli.msi')

# Download the installer to a temp location
remote_file 'MSI installer' do
  path temp_file
  source node['oneapm-ci-agent']['windows_agent_url'] + oneapm_ci_agent_msi
  # As of v1.37, the windows cookbook doesn't upgrade the package if a newer version is downloaded
  # As a workaround uninstall the package first if a new MSI is downloaded
  notifies :remove, 'windows_package[Oneapm-ci Agent]', :immediately
end

# Install the package
windows_package 'Oneapm-ci Agent' do
  source temp_file
  options %(LICENSEKEY="#{node['oneapm-ci-agent']['license_key']}" HOSTNAME="#{node['hostname']}" TAGS="#{node['tags'].join(',')}")
  action :install
end
