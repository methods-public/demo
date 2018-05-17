include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor mongo
#
# node.set['cloudinsight-agent']['mongo']['instances'] = [
#   {
#     'host' => 'localhost',
#     'port' => '27017'
#   }
# ]

cloudinsight_agent_monitor 'mongo' do
  instances node['cloudinsight-agent']['mongo']['instances']
end
