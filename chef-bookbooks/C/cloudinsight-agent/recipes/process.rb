include_recipe 'cloudinsight-agent::cloudinsight-agent'

# Monitor processes
#
#    name:          (mandatory) STRING Is the display name of the check
#    search_string: (mandatory) LIST OF STRINGS The strings to search for in process names. If
#                               one of these matches a process's name, that process will be
#                               included in the stats.
#    exact_match:   (optional)  True/False, defaults to True, if you want to look for a partial
#                               match, use exact_match: "False", otherwise use the exact base
#                               name of the process.
#
# Example:
#
# node.cloudinsight-agent.process.instances = [
#   {
#     :name => "ssh",
#     :search_string => ["ssh","sshd"],
#     :exact_match => "False",
#   },
#   {
#     :name => "postgres",
#     :search_string => ["postgres"],
#   },
# ]

cloudinsight_agent_monitor 'process' do
  instances node['cloudinsight-agent']['process']['instances']
end
