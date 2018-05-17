#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: zookeeper
#

include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

oneapm_ci_agent_monitor 'zk' do
  instances node['oneapm-ci-agent']['zookeeper']['instances']
end
