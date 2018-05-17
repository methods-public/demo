#
# Cookbook:: chef_wazuh
# Recipe:: default
#
# MIT

# Warn that the default recipe does nothing.
log 'chef_wazuh::warning' do
  message 'The default chef_wazuh recipe does nothing. Use `chef_wazuh::agent` to install the agent.'
  level :warn
end

# Only run on supported platforms
if %w(debian ubuntu redhat centos).include? node['platform']

  # Warn that the platform this was run on is not supported
  log 'chef_wazuh::platform::warning' do
    message "Platform: \"#{node['platform']}\" is not supported. Moving on..."
    level :warn
  end

end
