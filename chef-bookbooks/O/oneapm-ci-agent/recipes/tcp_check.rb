include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor tcp
#
# Assuming you have tcp connections you want to monitor
# you need to set up the following attributes
# node.oneapm-ci-agent.tcp_check.instances = [
#   {
#     :name => "http",
#     :host => "localhost",
#     :port => 80
#   }
# ]

oneapm_ci_agent_monitor 'tcp_check' do
  instances node['oneapm-ci-agent']['tcp_check']['instances']
end
