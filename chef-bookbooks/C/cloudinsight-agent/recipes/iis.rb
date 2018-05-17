include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Integrate IIS metrics
#
# Simply declare the following attributes
# One instance per server.
#
# node.cloudinsight-agent.iis.instances = [
#                               {
#                                 "host" => "localhost",
#                                 "tags" => ["prod", "other_tag"]
#                               },
#                               {
#                                 "host" => "other.server.com",
#                                 "username" => "myuser",
#                                 "password" => "password",
#                                 "tags" => ["prod", "other_tag"]
#                               }
#                              ]

cloudinsight_agent_monitor 'iis' do
  instances node['cloudinsight-agent']['iis']['instances']
end
