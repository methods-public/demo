include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor Kafka
#
# You need to set up the following attributes
# node.cloudinsight-agent.kafka_consumer.instances = [
#   {
#     :kafka_connect_str => "localhost:19092",
#     :zk_connect_str => "localhost:2181",
#     :zk_prefix => "/0.8"
#   }
# ]

cloudinsight_agent_monitor 'kafka_consumer' do
  instances node['cloudinsight-agent']['kafka_consumer']['instances']
end
