#
# Cookbook Name:: cloudinsight-agent
# Recipe:: pgbouncer
#

include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['pgbouncer']['instances'] = [
#     {
#       host: 'localhost',
#       port: '15432',
#       username: 'john',
#       password: 'doe',
#       tags: [
#         'optional_tag1',
#         'optional_tag2'
#       ]
#     }
#   ]

cloudinsight_agent_monitor 'pgbouncer' do
  instances node['cloudinsight-agent']['pgbouncer']['instances']
end
