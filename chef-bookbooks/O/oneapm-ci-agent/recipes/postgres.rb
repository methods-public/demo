include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['postgres']['instances'] = [
#     {
#       'server' => "localhost",
#       'port' => "5432",
#       'username' => "oneapm-ci-agent",
#       'tags' => ["test"]
#     },
#     {
#       'server' => "remote",
#       'port' => "5432",
#       'username' => "oneapm-ci-agent",
#       'tags' => ["prod"],
#       'dbname' => 'my_database',
#       'ssl' => true,
#       'relations' => ["apple_table", "orange_table"]
#     }
#   ]
# @todo Breaking, major version, convert `server` to `host` to match the check input.
# @todo Breaking, major version, convert template to yaml-style

oneapm_ci_agent_monitor 'postgres' do
  instances node['oneapm-ci-agent']['postgres']['instances']
end
