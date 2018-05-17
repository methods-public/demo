include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor Kafka
#
# Assuming you have 2 clusters "test" and "prod",
# one with and one without authentication
# you need to set up the following attributes
# node.oneapm-ci-agent.kafka.instances = [
#   {
#     :host => "localhost",
#     :port => "9999",
#     :name => "prod",
#     :user => "username",
#     :password => "secret"
#   },
#   {
#     :host => "localhost",
#     :port => "8199",
#     :name => "test"
#   }
# ]

oneapm_ci_agent_monitor 'kafka' do
  instances node['oneapm-ci-agent']['kafka']['instances']
end
