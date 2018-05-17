#
# Cookbook Name:: netdevops
# Recipe:: user
#
# Copyright 2015 John Deatherage
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

group node['netdevops']['user']['group']

user node['netdevops']['user']['name'] do
  system true
  comment 'NetDevOps default user'
  home node['netdevops']['user']['home']
  group node['netdevops']['user']['group']
  supports manage_home: true
  shell '/bin/bash'
end
