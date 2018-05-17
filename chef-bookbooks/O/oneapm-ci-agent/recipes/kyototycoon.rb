include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Integrate Kyoto Tycoon metrics into oneapm-ci-agent
#
# To configure, simply set atributes according to the following example
#
# node.oneapm-ci-agent.kyototycoon.instances = [
#                                       {
#                                         "name" => "dev",
#                                         "report_url" => "http://localhost:1978/rpc/report",
#                                         "tags" => { "key1" => "value1", "key2" => "value2" }
#                                       },
#                                       {
#                                         "name" => "prod",
#                                         "report_url" => "http://localhost:2978/rpc/report",
#                                         "tags" => { "key3" => "value3", "key4" => "value4" }
#                                       }
#                                      ]

oneapm_ci_agent_monitor 'kyototycoon' do
  instances node['oneapm-ci-agent']['kyototycoon']['instances']
end
