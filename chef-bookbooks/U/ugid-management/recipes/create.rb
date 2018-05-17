#
# Copyright (c) 2016 Sam4Mobile, 2017-2018 Make.org
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

::Chef::Recipe.send(:include, UGIdManagement)

users_db = node[cookbook_name]['data_bag']['users']

node[cookbook_name]['users_manage'].each do |group|
  _, gid = ugid_of(group)
  users_manage group do
    action %i[remove create]
    data_bag users_db
    group_id gid
  end
end
