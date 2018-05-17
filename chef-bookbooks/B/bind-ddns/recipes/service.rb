#
# Copyright (c) 2015-2017 Sam4Mobile, 2017-2018 Make.org
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

# Config initialization
include_recipe "#{cookbook_name}::init"
config = node.run_state[cookbook_name]['config']

sysconfig_file = node[cookbook_name]['sysconfig_file']
sysconfig_config = node[cookbook_name]['sysconfig_config']

file sysconfig_file do
  content "#{sysconfig_config.map { |k, v| "#{k}=#{v}" }.join("\n")}\n"
end

# Enable/Start service
service 'named' do
  service_name config['service_name']
  supports status: true, restart: true, reload: true
  action %i[enable start]
  subscribes :reload, 'execute[named-checkconf]'
  subscribes :restart, "file[#{sysconfig_file}]"
end
