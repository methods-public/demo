include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor apache
#
# Assuming you have 2 instances "prod" and "test", you will need to set
# up the following attributes at some point in your Chef run, in either
# a role or another cookbook.
#
# node['cloudinsight-agent']['apache']['instances'] = [
#   {
#     'status_url' => "http://localhost:81/status/",
#     'tags' => ["prod"]
#   },
#   {
#     'status_url' => "http://localhost:82/status/",
#     'name' => ["test"]
#   }
# ]

cloudinsight_agent_monitor 'apache' do
  instances node['cloudinsight-agent']['apache']['instances']
end
