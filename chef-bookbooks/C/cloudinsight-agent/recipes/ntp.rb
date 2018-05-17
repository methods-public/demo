include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @note NTP check is enabled by default.
# @example
#   node.override['cloudinsight-agent']['ntp']['instances'] = [
#     {
#       'offset_threshold' => '60',
#       'host' => 'pool.ntp.org',
#       'port' => 'ntp',
#       'version' => '3',
#       'timeout' => '5'
#     }
#   ]
cloudinsight_agent_monitor 'ntp' do
  instances node['cloudinsight-agent']['ntp']['instances']
end
