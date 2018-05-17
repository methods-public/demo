include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Integrate IIS metrics
#
# Simply declare the following attributes
# One instance per server.
#
# node.oneapm-ci-agent.iis.instances = [
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

oneapm_ci_agent_monitor 'iis' do
  instances node['oneapm-ci-agent']['iis']['instances']
end
