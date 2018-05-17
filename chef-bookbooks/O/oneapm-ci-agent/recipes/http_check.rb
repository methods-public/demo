include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['http_check']['instances'] = [
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

oneapm_ci_agent_monitor 'http_check' do
  instances node['oneapm-ci-agent']['http_check']['instances']
end
