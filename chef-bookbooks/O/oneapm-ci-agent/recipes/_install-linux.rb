#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: _install-linux
#

# Install the Apt/Yum repository if enabled
include_recipe 'oneapm-ci-agent::repository' if node['oneapm-ci-agent']['installrepo']

oneapm_ci_agent_version = node['oneapm-ci-agent']['agent_version']

# If version specified and lower than 5.x
if !oneapm_ci_agent_version.nil? && oneapm_ci_agent_version.split('.')[0].to_i < 5
  Chef::Log.warn 'Support for Agent pre 5.x will be removed in oneapm-ci-agent cookbook version 1.0'
  # Select correct package name based on attribute
  oneapm_ci_agent_pkg_name = node['oneapm-ci-agent']['install_base'] ? 'oneapm-ci-agent-base' : 'oneapm-ci-agent'

  package oneapm_ci_agent_pkg_name do
    version oneapm_ci_agent_version
  end
else
  # default behavior, remove the `base` package as it is no longer needed
  package 'oneapm-ci-agent-base' do
    action :remove
    not_if 'rpm -q oneapm-ci-agent-base' if %w(rhel fedora).include?(node['platform_family'])
    not_if 'apt-cache policy oneapm-ci-agent-base | grep "Installed: (none)"' if node['platform_family'] == 'debian'
  end
  # Install the regular package
  package 'oneapm-ci-agent' do
    version oneapm_ci_agent_version
    action node['oneapm-ci-agent']['agent_package_action'] # default is :install
  end
end
