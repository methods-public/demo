include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor fluentd
#
# node.override['oneapm-ci-agent']['fluentd']['instances'] = [
#   {
#     'monitor_agent_url' => "http://example.com:24220/api/plugins.json",
#     'plugin_ids' => ["plg1", "plg2"],
#     'tags' => ["tag1", "tag2"]
#   }
# ]

oneapm_ci_agent_monitor 'fluentd' do
  instances node['oneapm-ci-agent']['fluentd']['instances']
end
