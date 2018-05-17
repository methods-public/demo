include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['redisdb']['instances'] = [
#     {
#       'server' => 'localhost',
#       'port' => '6379',
#       'password' 'somesecret',
#       'tags' => ['prod']
#     }
#   ]
cloudinsight_agent_monitor 'redisdb' do
  instances node['cloudinsight-agent']['redisdb']['instances']
end
