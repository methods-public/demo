#
# Cookbook Name:: cloudinsight-agent
# Recipe:: mesos
#

include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['mesos'] =
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

cloudinsight_agent_monitor 'mesos' do
  init_config node['cloudinsight-agent']['mesos']['init_config']
  instances node['cloudinsight-agent']['mesos']['instances']
end
