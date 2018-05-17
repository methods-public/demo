include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor network
#
# node.oneapm-ci-agent.network.instances = [
#   {
#     :collect_connection_state => "false",
#     :excluded_interfaces => ["lo","lo0"]
#   },
# ]

Chef::Log.warn 'oneapm-ci-agent network check only supports one `instance`, please check attribute assignments' if node['oneapm-ci-agent']['network']['instances'].count > 1

oneapm_ci_agent_monitor 'network' do
  instances node['oneapm-ci-agent']['network']['instances']
end
