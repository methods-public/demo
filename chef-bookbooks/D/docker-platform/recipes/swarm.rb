#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include ClusterSearch
::Chef::Recipe.send(:include, ClusterSearch)

# Return if we do not want swarm activated on this node
return unless node[cookbook_name]['swarm']['enabled?']

# Use ClusterSearch to find the list of managers
managers = cluster_search(node[cookbook_name]['swarm'])
return if managers.nil?

# If I'm not in the managers list, I'm a worker
my_role = managers['my_id'] == -1 ? 'worker' : 'manager'

# Use ClusterSearch for consul_backend discovery
# Only first host of cluster will be used to connect
consul_cluster = cluster_search(node[cookbook_name]['swarm']['consul'])
return if consul_cluster.nil?
consul_addr = consul_cluster['hosts'].first

# Gem needed to interact with consul
chef_gem 'diplomat' do
  compile_time false
end

# Init swarm and deploy service using custom resources/providers on

docker_platform_swarm node[cookbook_name]['swarm']['role'] do
  role my_role
  consul_addr consul_addr
  consul_port node[cookbook_name]['swarm']['consul']['port']
  join_opts node[cookbook_name]['swarm']['join_opts']
  init_opts node[cookbook_name]['swarm']['init_opts']
  retries node[cookbook_name]['swarm']['join_retry_number']
  retry_delay node[cookbook_name]['swarm']['join_retry_delay']
  action %i[unregister init join register]
end
