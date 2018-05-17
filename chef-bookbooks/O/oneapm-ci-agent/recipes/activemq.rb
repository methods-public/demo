include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor activemq
#
# Assuming you have 2 clusters "test" and "prod",
# one with and one without authentication
# you need to set up the following attributes
# node.oneapm-ci-agent.activemq.instances = [
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

oneapm_ci_agent_monitor 'activemq' do
  instances node['oneapm-ci-agent']['activemq']['instances']
end
