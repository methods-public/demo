include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Integrate memcache metrics into oneapm-ci-agent
#
# Simply set up attributes following this example.
# If you are running multiple memcache instances on the same machine
# list them all as hashes.
#
# node.oneapm-ci-agent.memcache.instances = [
#                                    {
#                                      "url" => "localhost",
#                                      "port" => "11211",
#                                      "tags" => ["prod", "aws"]
#                                    }
#                                   ]

oneapm_ci_agent_monitor 'mcache' do
  instances node['oneapm-ci-agent']['memcache']['instances']
end
