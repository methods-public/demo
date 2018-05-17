#
# Cookbook Name:: cloudinsight-agent
# Recipe:: _install-linux
#

# Install the Apt/Yum repository if enabled
include_recipe 'cloudinsight-agent::repository' if node['cloudinsight-agent']['installrepo']

cloudinsight_agent_version = node['cloudinsight-agent']['agent_version']

# If version specified and lower than 5.x
if !cloudinsight_agent_version.nil? && cloudinsight_agent_version.split('.')[0].to_i < 5
  Chef::Log.warn 'Support for Agent pre 5.x will be removed in cloudinsight-agent cookbook version 1.0'
  # Select correct package name based on attribute
  cloudinsight_agent_pkg_name = node['cloudinsight-agent']['install_base'] ? 'cloudinsight-agent-base' : 'cloudinsight-agent'

  package cloudinsight_agent_pkg_name do
    version cloudinsight_agent_version
  end
else
  # default behavior, remove the `base` package as it is no longer needed
  package 'cloudinsight-agent-base' do
    action :remove
    not_if 'rpm -q cloudinsight-agent-base' if %w(rhel fedora).include?(node['platform_family'])
    not_if 'apt-cache policy cloudinsight-agent-base | grep "Installed: (none)"' if node['platform_family'] == 'debian'
  end
  # Install the regular package
  package 'cloudinsight-agent' do
    version cloudinsight_agent_version
    action node['cloudinsight-agent']['agent_package_action'] # default is :install
  end
end
