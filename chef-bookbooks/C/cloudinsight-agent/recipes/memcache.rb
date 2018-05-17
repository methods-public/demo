include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Integrate memcache metrics into cloudinsight-agent
#
# Simply set up attributes following this example.
# If you are running multiple memcache instances on the same machine
# list them all as hashes.
#
# node.cloudinsight-agent.memcache.instances = [
#                                    {
#                                      "url" => "localhost",
#                                      "port" => "11211",
#                                      "tags" => ["prod", "aws"]
#                                    }
#                                   ]

cloudinsight_agent_monitor 'mcache' do
  instances node['cloudinsight-agent']['memcache']['instances']
end
