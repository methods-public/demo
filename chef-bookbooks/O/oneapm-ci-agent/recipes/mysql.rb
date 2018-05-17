include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor mysql
#
# Assuming you have 1 mysql instance "prod"  on a given server, you will need to set
# up the following attributes at some point in your Chef run, in either
# a role or another cookbook.
#
# node['oneapm-ci-agent']['mysql']['instances'] = [
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

oneapm_ci_agent_monitor 'mysql' do
  instances node['oneapm-ci-agent']['mysql']['instances']
end
