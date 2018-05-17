include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor network
#
# node.cloudinsight-agent.network.instances = [
#   {
#     :collect_connection_state => "false",
#     :excluded_interfaces => ["lo","lo0"]
#   },
# ]

Chef::Log.warn 'cloudinsight-agent network check only supports one `instance`, please check attribute assignments' if node['cloudinsight-agent']['network']['instances'].count > 1

cloudinsight_agent_monitor 'network' do
  instances node['cloudinsight-agent']['network']['instances']
end
