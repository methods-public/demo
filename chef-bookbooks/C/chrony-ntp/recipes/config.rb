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

# Deploy chrony configuration
platform = get_platform_specific(node['platform'])
header = "# Produced by Chef -- changes will be overwritten\n"
content = node[cookbook_name]['config'].to_h.map do |hk, hv|
  if hv.is_a?(Array)
    hv = node[cookbook_name]['default'][hk] if hv.empty?
    hv.map { |v| "#{hk} #{v}" }
  else
    "#{hk} #{hv}".strip
  end
end

auto_restart = node[cookbook_name]['auto_restart']
file platform['config_file'] do
  content "#{header}\n#{content.join("\n")}"
  mode '0644'
  notifies :restart, "service[#{platform['service']}]" if auto_restart
end
