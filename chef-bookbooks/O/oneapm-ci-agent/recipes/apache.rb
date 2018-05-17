include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor apache
#
# Assuming you have 2 instances "prod" and "test", you will need to set
# up the following attributes at some point in your Chef run, in either
# a role or another cookbook.
#
# node['oneapm-ci-agent']['apache']['instances'] = [
#   {
#     'status_url' => "http://localhost:81/status/",
#     'tags' => ["prod"]
#   },
#   {
#     'status_url' => "http://localhost:82/status/",
#     'name' => ["test"]
#   }
# ]

oneapm_ci_agent_monitor 'apache' do
  instances node['oneapm-ci-agent']['apache']['instances']
end
