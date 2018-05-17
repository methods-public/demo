include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Build a data structure with configuration.
# @example
#   node.override['cloudinsight-agent']['jmx']['instances'] = [
#     {
#       'host' => 'localhost',
#       'port' => 7199,
#       'name' 'prod_jmx_app',
#       'conf' => [
#         'include' => {
#           'attributes' => ['Capacity', 'Used'],
#           'bean_name' => 'com.cloudinsight-agent.test:type=BeanType,tag1=my_bean_name',
#           'domain' => 'com.cloudinsight-agent.test'
#         }
#       ]
#     }
#   ]
cloudinsight_agent_monitor 'jmx' do
  instances node['cloudinsight-agent']['jmx']['instances']
end
