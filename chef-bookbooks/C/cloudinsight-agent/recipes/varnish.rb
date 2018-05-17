include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor Varnish
#
# You'll need to set up the following attributes:
# node.cloudinsight-agent.varnish.instances = [
#
#   # Path to varnishstat (required)
#   {
#     :varnishstat => "/opt/local/bin/varnishstat"
#   },
#
#   # Tags to apply to all varnish metrics (optional)
#   {
#     :tags => ["test", "cache"]
#   },
#
#   # Varnish instance name, passed to varnishstat -n (optional)
#   {
#     :name => "myvarnish0"
#   }
# ]

cloudinsight_agent_monitor 'varnish' do
  instances node['cloudinsight-agent']['varnish']['instances']
end
