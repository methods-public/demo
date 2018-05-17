include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @note NTP check is enabled by default.
# @example
#   node.override['oneapm-ci-agent']['ntp']['instances'] = [
#     {
#       'offset_threshold' => '60',
#       'host' => 'pool.ntp.org',
#       'port' => 'ntp',
#       'version' => '3',
#       'timeout' => '5'
#     }
#   ]
oneapm_ci_agent_monitor 'ntp' do
  instances node['oneapm-ci-agent']['ntp']['instances']
end
