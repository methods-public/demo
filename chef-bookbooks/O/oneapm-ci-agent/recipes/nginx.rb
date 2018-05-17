include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor nginx
#
# Assuming you have 2 instances "prod" and "test", you will need to set
# up the following attributes at some point in your Chef run, in either
# a role or another cookbook.
#
# node['oneapm-ci-agent']['nginx']['instances'] = [
#   {
#     'nginx_status_url' => "http://localhost:81/nginx_status/",
#     'tags' => ["prod"]
#   },
#   {
#     'nginx_status_url' => "http://localhost:82/nginx_status/",
#     'name' => ["test"]
#   }
# ]

oneapm_ci_agent_monitor 'nginx' do
  instances node['oneapm-ci-agent']['nginx']['instances']
end
