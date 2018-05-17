#
# Cookbook Name:: cloudinsight-agent
# Recipe:: zookeeper
#

include_recipe 'cloudinsight-agent::cloudinsight-agent'

cloudinsight_agent_monitor 'zk' do
  instances node['cloudinsight-agent']['zookeeper']['instances']
end
