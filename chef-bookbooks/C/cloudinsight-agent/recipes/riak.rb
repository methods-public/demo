include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor riak
#
# node.cloudinsight-agent.riak.instances = [
#   {
#     :url => "http://localhost:8098/stats",
#   }
# ]

cloudinsight_agent_monitor 'riak' do
  instances node['cloudinsight-agent']['riak']['instances']
end
