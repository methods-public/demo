include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Integrate rabbitmq metrics into oneapm-ci-agent
#
# Set up attributes following this example.
# If you are running multiple rabbitmq instances on the same machine
# list them all as hashes.
#
# node.oneapm-ci-agent.rabbitmq.instances = [
#                                    {
#                                      "api_url" => "http://localhost:15672/api/",
#                                      "user" => "guest",
#                                      "pass" => "guest"
#                                    }
#                                   ]

oneapm_ci_agent_monitor 'rabbitmq' do
  instances node['oneapm-ci-agent']['rabbitmq']['instances']
end
