include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor fluentd
#
# node.override['cloudinsight-agent']['fluentd']['instances'] = [
#   {
#     'monitor_agent_url' => "http://example.com:24220/api/plugins.json",
#     'plugin_ids' => ["plg1", "plg2"],
#     'tags' => ["tag1", "tag2"]
#   }
# ]

cloudinsight_agent_monitor 'fluentd' do
  instances node['cloudinsight-agent']['fluentd']['instances']
end
