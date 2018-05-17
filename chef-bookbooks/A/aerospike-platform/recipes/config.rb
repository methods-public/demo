#
# Copyright (c) 2016 Sam4Mobile, 2018 Make.org
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

return if node.run_state.dig(cookbook_name, 'cluster').nil?

cluster = node.run_state[cookbook_name]['cluster']

# Set aerospike config
config_file = "#{node[cookbook_name]['prefix_root']}/aerospike/aerospike.conf"
config = node[cookbook_name]['config'].to_hash

# Configure networking options for clustering
heartbeat_port = config['network']['heartbeat']['port']
peers = cluster['hosts'].map { |host| "#{host} #{heartbeat_port}" }

peers.each do |peer|
  config['network']['heartbeat']["mesh-seed-address-port #{peer}"] = ''
end

# Deploy aerospike config
file config_file do
  content generate_config(config)
  owner node[cookbook_name]['user']
  group node[cookbook_name]['group']
  mode '0640'
end
