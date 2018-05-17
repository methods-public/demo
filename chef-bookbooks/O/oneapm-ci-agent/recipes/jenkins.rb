include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Integrate jenkins builds
#
# To configure the integration of one or more jenkins servers into oneapm-ci-agent
# simply set up attributes for the jenkins nodes or roles like so:
#
# node.oneapm-ci-agent.jenkins.instances = [
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

oneapm_ci_agent_monitor 'jenkins' do
  instances node['oneapm-ci-agent']['jenkins']['instances']
end
