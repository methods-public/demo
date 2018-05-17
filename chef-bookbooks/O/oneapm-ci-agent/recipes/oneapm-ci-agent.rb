#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: oneapm-ci-agent
#

# Install the agent
if node['platform_family'] == 'windows'
  include_recipe 'oneapm-ci-agent::_install-windows'
else
  include_recipe 'oneapm-ci-agent::_install-linux'
end

# Set the correct Agent startup action
agent_action = node['oneapm-ci-agent']['agent_start'] ? :start : :stop
# Set the correct config file
agent_config_file = ::File.join(node['oneapm-ci-agent']['config_dir'], 'oneapm-ci-agent.conf')

# Make sure the config directory exists
directory node['oneapm-ci-agent']['config_dir'] do
  if node['platform_family'] == 'windows'
    owner 'Administrators'
    rights :full_control, 'Administrators'
    inherits false
  else
    owner 'oneapm-ci-agent'
    group 'root'
    mode 0755
  end
end

#
# Configures a basic agent
# To add integration-specific configurations, add 'oneapm-ci-agent::config_name' to
# the node's run_list and set the relevant attributes
#
raise "Add a ['oneapm-ci-agent']['license_key'] attribute to configure this node's oneapm-ci-agent." if node['oneapm-ci-agent'] && node['oneapm-ci-agent']['license_key'].nil?

template agent_config_file do
  if node['platform_family'] == 'windows'
    owner 'Administrators'
    rights :full_control, 'Administrators'
    inherits false
  else
    owner 'oneapm-ci-agent'
    group 'root'
    mode 0640
  end
  variables(
    :license_key => node['oneapm-ci-agent']['license_key'],
    :ci_url => node['oneapm-ci-agent']['ci_url']
  )
end

# Common configuration
service 'oneapm-ci-agent' do
  service_name node['oneapm-ci-agent']['agent_name']
  action [:enable, agent_action]
  if node['platform_family'] == 'windows'
    supports :restart => true, :start => true, :stop => true
  else
    supports :restart => true, :status => true, :start => true, :stop => true
  end
  subscribes :restart, "template[#{agent_config_file}]", :delayed unless node['oneapm-ci-agent']['agent_start'] == false
end
