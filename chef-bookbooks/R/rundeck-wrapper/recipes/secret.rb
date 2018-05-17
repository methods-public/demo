#
# Copyright (c) 2017 Make.org
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

# Retrieve realm users credentials from data bag
data_bag_name = node[cookbook_name]['data_bag']['realm_users']
realm_properties = {}

data_bag(data_bag_name).each do |item|
  user = data_bag_item(data_bag_name, item)
  next if (node[cookbook_name]['whitelist'] & user['groups']).empty?\
          || user['rundeck_password'].nil?
  groups = user['groups'].join(',') << ",#{node['rundeck_server']['rolename']}"
  realm_properties[item] = "#{user['rundeck_password']},#{groups}"
end

resource = resources(template: ['realm.properties'])
resource.variables(properties: realm_properties)
