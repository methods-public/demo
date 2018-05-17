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

# Define journalbeat group
group node[cookbook_name]['group'] do
  system true
end

# Define journalbeat user
user node[cookbook_name]['user'] do
  group node[cookbook_name]['group']
  shell '/sbin/nologin'
  system true
end

# Add journalbeat user to systemd journal group
group "#{cookbook_name}:systemd_journal" do
  group_name node[cookbook_name]['systemd_journal_group']
  members node[cookbook_name]['user']
  append true
  action :modify
  not_if { node[cookbook_name]['systemd_journal_group'].empty? }
end
