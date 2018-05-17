include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor mongo
#
# node.set['oneapm-ci-agent']['mongo']['instances'] = [
#   {
#     'host' => 'localhost',
#     'port' => '27017'
#   }
# ]

oneapm_ci_agent_monitor 'mongo' do
  instances node['oneapm-ci-agent']['mongo']['instances']
end
