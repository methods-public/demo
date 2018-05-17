include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor nginx
#
# Assuming you have 2 instances "prod" and "test", you will need to set
# up the following attributes at some point in your Chef run, in either
# a role or another cookbook.
#
# node['cloudinsight-agent']['nginx']['instances'] = [
#   {
#     'nginx_status_url' => "http://localhost:81/nginx_status/",
#     'tags' => ["prod"]
#   },
#   {
#     'nginx_status_url' => "http://localhost:82/nginx_status/",
#     'name' => ["test"]
#   }
# ]

cloudinsight_agent_monitor 'nginx' do
  instances node['cloudinsight-agent']['nginx']['instances']
end
