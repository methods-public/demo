include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor cassandra
#
# Assuming you have 2 clusters "test" and "prod",
# one with and one without authentication
# you need to set up the following attributes
#
# node['cloudinsight-agent']['cassandra']['instances'] = [
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
cloudinsight_agent_monitor 'cassandra' do
  instances node['cloudinsight-agent']['cassandra']['instances']
end
