#
# Cookbook Name:: cloudinsight-agent
# Recipe:: cloudinsight-agent
#

# Install the agent
if node['platform_family'] == 'windows'
  include_recipe 'cloudinsight-agent::_install-windows'
else
  include_recipe 'cloudinsight-agent::_install-linux'
end

# Set the correct Agent startup action
agent_action = node['cloudinsight-agent']['agent_start'] ? :start : :stop
# Set the correct config file
agent_config_file = ::File.join(node['cloudinsight-agent']['config_dir'], 'cloudinsight-agent.conf')

# Make sure the config directory exists
directory node['cloudinsight-agent']['config_dir'] do
  if node['platform_family'] == 'windows'
    owner 'Administrators'
    rights :full_control, 'Administrators'
    inherits false
  else
    owner 'cloudinsight-agent'
    group 'root'
    mode 0755
  end
end

#
# Configures a basic agent
# To add integration-specific configurations, add 'cloudinsight-agent::config_name' to
# the node's run_list and set the relevant attributes
#
raise "Add a ['cloudinsight-agent']['license_key'] attribute to configure this node's cloudinsight-agent." if node['cloudinsight-agent'] && node['cloudinsight-agent']['license_key'].nil?

template agent_config_file do
  if node['platform_family'] == 'windows'
    owner 'Administrators'
    rights :full_control, 'Administrators'
    inherits false
  else
    owner 'cloudinsight-agent'
    group 'root'
    mode 0640
  end
  variables(
    :license_key => node['cloudinsight-agent']['license_key'],
    :ci_url => node['cloudinsight-agent']['ci_url']
  )
end

# Common configuration
service 'cloudinsight-agent' do
  service_name node['cloudinsight-agent']['agent_name']
  action [:enable, agent_action]
  if node['platform_family'] == 'windows'
    supports :restart => true, :start => true, :stop => true
  else
    supports :restart => true, :status => true, :start => true, :stop => true
  end
  subscribes :restart, "template[#{agent_config_file}]", :delayed unless node['cloudinsight-agent']['agent_start'] == false
end
