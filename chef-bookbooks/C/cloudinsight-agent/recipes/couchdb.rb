include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor couchDB
#
# Assuming you have 2 instances on the same host
# you need to set up the following attributes.
# Each instance's metric will be tagged with "instance:server_url".
# to help you differentiate between instances.
# NOTE the "couch" instead of "couchdb" attribute.
#
# node['cloudinsight-agent']['couch']['instances'] = [
#                                 {
#                                  server: 'http://localhost:1234'
#                                 },
#                                 {
#                                  server: 'http://localhost:4567'
#                                 }
#                                ]

cloudinsight_agent_monitor 'couch' do
  init_config nil
  instances node['cloudinsight-agent']['couch']['instances']
end
