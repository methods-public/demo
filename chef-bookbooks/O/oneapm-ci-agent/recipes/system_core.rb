#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: system_core
#

include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

oneapm_ci_agent_monitor 'system_core'
