#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: supervisord
#

include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['supervisord']['instances'] =
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

oneapm_ci_agent_monitor 'supervisord' do
  instances node['oneapm-ci-agent']['supervisord']['instances']
end
