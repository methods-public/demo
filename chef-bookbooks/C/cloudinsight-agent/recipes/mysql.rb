include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor mysql
#
# Assuming you have 1 mysql instance "prod"  on a given server, you will need to set
# up the following attributes at some point in your Chef run, in either
# a role or another cookbook.
#
# node['cloudinsight-agent']['mysql']['instances'] = [
#   {
#     'server' => "localhost",
#     'port' => 3306,
#     'user' => "my_username",
#     'pass' => "my_password",
#     'sock' => "/path/to/mysql.sock",
#     'tags' => ["prod"],
#     'options' => [
#       "replication: 0",
#       "galera_cluster: 1"
#     ]
#   },
# ]

cloudinsight_agent_monitor 'mysql' do
  instances node['cloudinsight-agent']['mysql']['instances']
end
