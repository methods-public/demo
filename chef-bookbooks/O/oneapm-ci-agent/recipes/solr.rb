include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor solr
# @example
#

oneapm_ci_agent_monitor 'solr' do
  instances node['oneapm-ci-agent']['solr']['instances']
end
