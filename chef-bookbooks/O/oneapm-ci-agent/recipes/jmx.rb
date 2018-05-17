include_recipe 'oneapm-ci-agent::oneapm-ci-agent'

# Build a data structure with configuration.
# @example
#   node.override['oneapm-ci-agent']['jmx']['instances'] = [
#     {
#       'host' => 'localhost',
#       'port' => 7199,
#       'name' 'prod_jmx_app',
#       'conf' => [
#         'include' => {
#           'attributes' => ['Capacity', 'Used'],
#           'bean_name' => 'com.oneapm-ci-agent.test:type=BeanType,tag1=my_bean_name',
#           'domain' => 'com.oneapm-ci-agent.test'
#         }
#       ]
#     }
#   ]
oneapm_ci_agent_monitor 'jmx' do
  instances node['oneapm-ci-agent']['jmx']['instances']
end
