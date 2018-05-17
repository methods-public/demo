include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor solr
# @example
#

cloudinsight_agent_monitor 'solr' do
  instances node['cloudinsight-agent']['solr']['instances']
end
