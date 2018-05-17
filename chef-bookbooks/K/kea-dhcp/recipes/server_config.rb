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

def dedup_array(obj)
  if obj.is_a?(Hash)
    obj.map { |k, v| [k, dedup_array(v)] }.to_h
  elsif obj.is_a?(Array)
    obj.reverse.uniq { |h| h.respond_to?(:first) ? h.first : h }.reverse
  else obj
  end
end

# Initialize configuration
include_recipe "#{cookbook_name}::init"
config = dedup_array(node.run_state[cookbook_name]['config']['kea-conf'])

header = "# Produced by Chef -- changes will be overwritten\n"
file '/etc/kea/kea.conf' do
  content header + Chef::JSONCompat.to_json_pretty(config)
end
