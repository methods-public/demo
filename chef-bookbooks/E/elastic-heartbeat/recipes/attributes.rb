#
# Cookbook Name:: elastic-heartbeat
# Recipe:: default
#
# Copyright 2017, Virender Khatri
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

major_version = node['heartbeat']['version'].split('.')[0]

node.default['elastic_beats_repo']['version'] = node['heartbeat']['version'] if node['heartbeat']['setup_repo']

# The package and service weren't namespaced with "-elastic" prior to 6.x
if major_version.to_i < 6
  node.default['heartbeat']['package_name'] = 'heartbeat'
  node.default['heartbeat']['service_name'] = 'heartbeat'
else
  node.default['heartbeat']['package_name'] = 'heartbeat-elastic'
  node.default['heartbeat']['service_name'] = 'heartbeat-elastic'
end
