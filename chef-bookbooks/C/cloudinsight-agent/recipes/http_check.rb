include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['http_check']['instances'] = [
#     {
#       'name' => 'MyHTTPcheck',
#       'url' => 'http://my.server/some/service',
#       'timeout' => '15',
#       'content_match' => 'string to match',
#       'include_content' => true,
#       'collect_response_time' => true,
#       'skip_event' => true,
#       'tags' => [
#        'myApp',
#        'serviceName'
#       ]
#     }
# ]

cloudinsight_agent_monitor 'http_check' do
  instances node['cloudinsight-agent']['http_check']['instances']
end
