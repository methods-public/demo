include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor consul
#
# Assuming you have a consul instance on a given server, you will need to set
# up the following attributes at some point in your Chef run, in either
# a role or another cookbook.
#
# Note that the Agent only supports monitoring one Consul instance
#
# A few explanatory words:
#  - `catalog_checks`: Whether to perform checks against the Consul service Catalog
#  - `new_leader_checks`: Whether to enable new leader checks from this agent
#     Note: if this is set on multiple agents in the same cluster
#     you will receive one event per leader change per agent
#  - `service_whitelist`: Services to restrict catalog querying to
#    The default settings query up to 50 services. So if you have more than
#    this many in your Consul service catalog, you will want to fill in the
#    whitelist
#
# node['cloudinsight-agent']['consul']['instances'] = [
#   {
#     'url'               => 'http://localhost:8500',
#     'new_leader_checks' => false,
#     'catalog_checks'    => false,
#     'service_whitelist' => [],
#     'tags'              => [node.chef_environment]
#   }
# ]

cloudinsight_agent_monitor 'consul' do
  instances node['cloudinsight-agent']['consul']['instances']
end
