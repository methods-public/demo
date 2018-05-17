#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: pgbouncer
#

include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['pgbouncer']['instances'] = [
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

oneapm_ci_agent_monitor 'pgbouncer' do
  instances node['oneapm-ci-agent']['pgbouncer']['instances']
end
