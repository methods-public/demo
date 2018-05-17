include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor tcp
#
# Assuming you have tcp connections you want to monitor
# you need to set up the following attributes
# node.cloudinsight-agent.tcp_check.instances = [
#   {
#     :name => "http",
#     :host => "localhost",
#     :port => 80
#   }
# ]

cloudinsight_agent_monitor 'tcp_check' do
  instances node['cloudinsight-agent']['tcp_check']['instances']
end
