include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['postgres']['instances'] = [
#     {
#       'server' => "localhost",
#       'port' => "5432",
#       'username' => "cloudinsight-agent",
#       'tags' => ["test"]
#     },
#     {
#       'server' => "remote",
#       'port' => "5432",
#       'username' => "cloudinsight-agent",
#       'tags' => ["prod"],
#       'dbname' => 'my_database',
#       'ssl' => true,
#       'relations' => ["apple_table", "orange_table"]
#     }
#   ]
# @todo Breaking, major version, convert `server` to `host` to match the check input.
# @todo Breaking, major version, convert template to yaml-style

cloudinsight_agent_monitor 'postgres' do
  instances node['cloudinsight-agent']['postgres']['instances']
end
