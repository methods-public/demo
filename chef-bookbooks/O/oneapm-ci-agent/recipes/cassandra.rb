include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor cassandra
#
# Assuming you have 2 clusters "test" and "prod",
# one with and one without authentication
# you need to set up the following attributes
#
# node['oneapm-ci-agent']['cassandra']['instances'] = [
#   {
#     host: 'localhost',
#     port: 7199,
#     name: 'prod',
#     user: 'username',
#     password: 'secret'
#   },
#   {
#     server: 'localhost',
#     port: 8199,
#     name: 'test'
#   }
# ]
#
oneapm_ci_agent_monitor 'cassandra' do
  instances node['oneapm-ci-agent']['cassandra']['instances']
end
