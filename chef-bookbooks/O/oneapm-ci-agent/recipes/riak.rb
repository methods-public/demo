include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor riak
#
# node.oneapm-ci-agent.riak.instances = [
#   {
#     :url => "http://localhost:8098/stats",
#   }
# ]

oneapm_ci_agent_monitor 'riak' do
  instances node['oneapm-ci-agent']['riak']['instances']
end
