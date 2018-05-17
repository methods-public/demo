#
# Cookbook:: chef_wazuh
# Recipe:: agent
#
# MIT

# Only run on supported platforms
if %w(debian ubuntu redhat centos).include? node['platform']

  if node['chef_wazuh']['agent']['server'].nil?

    # Warn that the platform this was run on is not supported
    log 'chef_wazuh::attr::warning' do
      message "node['chef_wazuh']['agent']['server'] is nil. Please provide a Wazuh server address!"
      level :warn
    end

  else

    # Define the command that adds the node to Wazuh
    execute 'wazuh_agent_auth' do
      command "/var/ossec/bin/agent-auth -m #{node['chef_wazuh']['agent']['server']}"
      action :nothing
    end

    # Setup the package manager repositories
    include_recipe 'chef_wazuh::repository'

    # Install the agent
    # Then notify the execute to run only after the package has been installed
    package 'wazuh-agent' do
      action :install
      notifies :run, 'execute[wazuh_agent_auth]', :immediately
    end

    # Configure OSSEC
    include_recipe 'chef_wazuh::configure_ossec'

  end

else

  # Warn that the platform this was run on is not supported
  log 'chef_wazuh::platform::warning' do
    message "Platform: \"#{node['platform']}\" is not supported. Moving on..."
    level :warn
  end

end