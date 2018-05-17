include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Monitor Kafka
#
# You need to set up the following attributes
# node.oneapm-ci-agent.kafka_consumer.instances = [
#   {
#     :kafka_connect_str => "localhost:19092",
#     :zk_connect_str => "localhost:2181",
#     :zk_prefix => "/0.8"
#   }
# ]

oneapm_ci_agent_monitor 'kafka_consumer' do
  instances node['oneapm-ci-agent']['kafka_consumer']['instances']
end
