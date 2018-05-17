#
# Cookbook Name:: cloudinsight-agent
# Recipe:: supervisord
#

include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['supervisord']['instances'] =
#     {
#       name: 'server0',
#       socket: 'unix:///var/run/default-supervisor.sock'
#     },
#     {
#       name: 'server1',
#       host: 'localhost',
#       port: '9001',
#       user: 'user',
#       pass: 'pass',
#       proc_names: [
#         'apache2',
#         'webapp'
#       ]
#     }

cloudinsight_agent_monitor 'supervisord' do
  instances node['cloudinsight-agent']['supervisord']['instances']
end
