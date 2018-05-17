include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Integrate rabbitmq metrics into cloudinsight-agent
#
# Set up attributes following this example.
# If you are running multiple rabbitmq instances on the same machine
# list them all as hashes.
#
# node.cloudinsight-agent.rabbitmq.instances = [
#                                    {
#                                      "api_url" => "http://localhost:15672/api/",
#                                      "user" => "guest",
#                                      "pass" => "guest"
#                                    }
#                                   ]

cloudinsight_agent_monitor 'rabbitmq' do
  instances node['cloudinsight-agent']['rabbitmq']['instances']
end
