include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor haproxy

# You need to set up the following attributes
# node.oneapm-ci-agent.haproxy.instances = [
#                                     {
#                                       :url => "http://localhost/stats_url",
#                                       :username => "username",
#                                       :password => "secret",
#                                       :status_check => false,
#                                       :collect_aggregates_only => true,
#                                       :collect_status_metrics => true
#                                     }
#                                    ]

oneapm_ci_agent_monitor 'haproxy' do
  instances node['oneapm-ci-agent']['haproxy']['instances']
end
