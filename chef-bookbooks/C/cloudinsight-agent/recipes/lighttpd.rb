include_recipe 'cloudinsight-agent::cloudinsight-agent'

cloudinsight_agent_monitor 'lighttpd' do
  instances node['cloudinsight-agent']['lighttpd']['instances']
end
