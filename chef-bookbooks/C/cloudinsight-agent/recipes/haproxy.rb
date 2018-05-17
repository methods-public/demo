include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor haproxy

# You need to set up the following attributes
# node.cloudinsight-agent.haproxy.instances = [
#                                     {
#                                       :url => "http://localhost/stats_url",
#                                       :username => "username",
#                                       :password => "secret",
#                                       :status_check => false,
#                                       :collect_aggregates_only => true,
#                                       :collect_status_metrics => true
#                                     }
#                                    ]

cloudinsight_agent_monitor 'haproxy' do
  instances node['cloudinsight-agent']['haproxy']['instances']
end
