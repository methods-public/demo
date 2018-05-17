#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: mesos
#

include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['mesos'] =
#     instances: [{
#       url: 'https://server:port',
#       timeout: 8,
#       tags: [
#         'optional_tag1',
#         'optional_tag2'
#       ]
#     }],
#     init_config: {
#       default_timeout: 10
#     }

oneapm_ci_agent_monitor 'mesos' do
  init_config node['oneapm-ci-agent']['mesos']['init_config']
  instances node['oneapm-ci-agent']['mesos']['instances']
end
