#
# Copyright (c) 2016-2017 Sam4Mobile, 2017 Make.org
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

# Create consul data && config directories
%w[data_dir config_dir].each do |dir|
  directory node[cookbook_name][dir] do
    user node[cookbook_name]['user']
    group node[cookbook_name]['user']
    mode '0755'
    recursive true
  end
end

# Get servers list (from search), used in main config
servers = node.run_state.dig(cookbook_name, 'hosts')
return if servers.nil? # No one, we wait

# Deploy consul configuration (services, health checks)
node[cookbook_name]['config'].each do |filename, config|
  if filename == node[cookbook_name]['main_config']
    config = config.to_hash
    if servers.include?(node['fqdn'])
      config['server'] = true
      config['bootstrap_expect'] = servers.size
    end
    config['retry_join'] = servers
  end
  file "#{node[cookbook_name]['config_dir']}/#{filename}" do
    content Chef::JSONCompat.to_json_pretty(config)
    owner node[cookbook_name]['user']
    group node[cookbook_name]['group']
    mode '0640'
  end
end
