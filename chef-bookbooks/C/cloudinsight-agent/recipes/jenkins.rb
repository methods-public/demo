include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Integrate jenkins builds
#
# To configure the integration of one or more jenkins servers into cloudinsight-agent
# simply set up attributes for the jenkins nodes or roles like so:
#
# node.cloudinsight-agent.jenkins.instances = [
#                                   {
#                                     "name" => "dev-jenkins",
#                                     "home" => "/var/lib/jenkins/dev"
#                                   },
#                                   {
#                                     "name" => "prod-jenkins",
#                                     "home" => "/var/lib/jenkins/prod"
#                                   }
#                                  ]
#
# Note that this check can only monitor local jenkins instances

cloudinsight_agent_monitor 'jenkins' do
  instances node['cloudinsight-agent']['jenkins']['instances']
end
