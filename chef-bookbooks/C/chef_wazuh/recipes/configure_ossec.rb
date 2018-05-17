#
# Cookbook:: chef_wazuh
# Recipe:: configure_ossec
#
# MIT

# Only run on supported platforms
if %w(debian ubuntu redhat centos).include? node['platform']

  if node['chef_wazuh']['agent']['ossec_config']['client']['server']['address'].nil?

    # Warn that the platform this was run on is not supported
    log 'chef_wazuh::attr::warning' do
      message "node['chef_wazuh']['agent']['ossec_config']['client']['server']['address'] is nil. Please provide an OSSEC server address!"
      level :warn
    end

  else

    config_platform = node['platform'].equal?('redhat') ? node['platform_family'] : node['platform']
    ossec_conf_path = node['chef_wazuh']['agent']['ossec_conf_path']

    ossec_config = node['chef_wazuh']['agent']['ossec_config']
    client_config_profile = []
    client_server_protocol = node['chef_wazuh']['agent']['ossec_config']['client']['server']['protocol']

    # Define the service
    service 'wazuh-agent' do
      action :nothing
    end

    # If the protocol is not set to UDP or TCP set it to UDP
    unless %w(udp tcp).include? client_server_protocol
      log 'chef_wazuh::ossec::protocol::warning' do
        message "Unknown protocol: \"#{client_server_protocol}\" supplied. Using \"udp\" as a fallback."
        level :warn
      end
      client_server_protocol = 'udp'
    end

    # Create an array with for the config profile option in the ossec conf
    client_config_profile.push(config_platform)
    if node['platform_version'].include? '.'
      client_config_profile.push("#{config_platform}#{node['platform_version'].split('.').first}")
    end
    client_config_profile.push("#{config_platform}#{node['platform_version']}")
    # Join the array into a comma separated string
    client_config_profile = client_config_profile.join(', ')

    # Create the ossec configuration from the ERB template
    template ossec_conf_path do
      source 'ossec.conf.erb'
      variables(
          platform: "#{node['platform'].capitalize}#{node['platform_version']}",
          config: ossec_config,
          client_config_profile: client_config_profile,
          client_server_protocol: client_server_protocol
      )
      notifies :restart, 'service[wazuh-agent]', :delayed
      action :create
    end

  end

else

  # Warn that the platform this was run on is not supported
  log 'chef_wazuh::platform::warning' do
    message "Platform: \"#{node['platform']}\" is not supported. Moving on..."
    level :warn
  end

end