#
# Copyright (c) 2017 Sam4Mobile, 2017-2018 Make.org
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

# Use ClusterSearch
::Chef::Recipe.send(:include, ClusterSearch)

# Looking for nodes of the cluster
cluster = cluster_search(node[cookbook_name])
return if cluster.nil?

s_index = node[cookbook_name]['seed_id'] - 1
n_of_seeds = node[cookbook_name]['n_of_seeds']

# Determine seeds nodes ids
if s_index < 0 || s_index == cluster['hosts'].size
  raise 'Invalid seed_id, should be between 1 and cluster.size'
end
if s_index + n_of_seeds > cluster['hosts'].size
  raise 'Invalid seeds range: id + n > cluster size'
end

node.run_state[cookbook_name] = {}
node.run_state[cookbook_name]['seeds'] =
  cluster['hosts'][s_index..(s_index + n_of_seeds - 1)]
