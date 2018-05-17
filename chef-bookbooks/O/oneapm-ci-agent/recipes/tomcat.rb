include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor tomcat
#
# Assuming you have 2 instances "test" and "prod",
# one with and one without authentication
# you need to set up the following attributes
# node.oneapm-ci-agent.tomcat.instances = [
#   {
#     :server => "localhost",
#     :port => "7199",
#     :name => "prod",
#     :username => "username",
#     :password => "secret"
#   },
#   {
#     :server => "localhost",
#     :port => "8199",
#     :name => "test"
#   }
# ]

oneapm_ci_agent_monitor 'tomcat' do
  instances node['oneapm-ci-agent']['tomcat']['instances']
end
