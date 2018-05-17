include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor Varnish
#
# You'll need to set up the following attributes:
# node.oneapm-ci-agent.varnish.instances = [
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

oneapm_ci_agent_monitor 'varnish' do
  instances node['oneapm-ci-agent']['varnish']['instances']
end
