include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor activemq
#
# Assuming you have 2 clusters "test" and "prod",
# one with and one without authentication
# you need to set up the following attributes
# node.cloudinsight-agent.activemq.instances = [
#                                     {
#                                       :host => "localhost",
#                                       :port => "1234",
#                                       :name => "prod",
#                                       :user => "username",
#                                       :password => "secret"
#                                     },
#                                     {
#                                       :host => "localhost",
#                                       :port => "3456",
#                                       :name => "test"
#                                     }
#                                    ]

cloudinsight_agent_monitor 'activemq' do
  instances node['cloudinsight-agent']['activemq']['instances']
end
