include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['redisdb']['instances'] = [
#     {
#       'server' => 'localhost',
#       'port' => '6379',
#       'password' 'somesecret',
#       'tags' => ['prod']
#     }
#   ]
oneapm_ci_agent_monitor 'redisdb' do
  instances node['oneapm-ci-agent']['redisdb']['instances']
end
