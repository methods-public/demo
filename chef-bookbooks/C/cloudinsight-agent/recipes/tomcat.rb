include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor tomcat
#
# Assuming you have 2 instances "test" and "prod",
# one with and one without authentication
# you need to set up the following attributes
# node.cloudinsight-agent.tomcat.instances = [
#   {
#     :server => "localhost",
#     :port => "7199",
#     :name => "prod",
#     :username => "username",
#     :password => "secret"
#   },
#   {
#     :server => "localhost",
#     :port => "8199",
#     :name => "test"
#   }
# ]

cloudinsight_agent_monitor 'tomcat' do
  instances node['cloudinsight-agent']['tomcat']['instances']
end
