#
# Cookbook Name:: cloudinsight-agent
# Recipe:: system_core
#

include_recipe 'cloudinsight-agent::cloudinsight-agent'

cloudinsight_agent_monitor 'system_core'
