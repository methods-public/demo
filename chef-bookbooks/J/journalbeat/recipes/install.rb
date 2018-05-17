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

# Create journalbeat home directory
directory node[cookbook_name]['home_dir'] do
  group node[cookbook_name]['user']
  group node[cookbook_name]['group']
  recursive true
  mode '0755'
end

# Symlink directory
link "#{node[cookbook_name]['root_dir']}/journalbeat" do
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
  to node[cookbook_name]['home_dir']
end

# Install journalbeat
remote_file node[cookbook_name]['bin'] do
  source node[cookbook_name]['mirror']
  owner node[cookbook_name]['user']
  group node[cookbook_name]['group']
  mode '0755'
  action :create
end
