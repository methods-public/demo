#
# Copyright (c) 2015-2016 Sam4Mobile, 2017 Make.org
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

# Initialize configuration
include_recipe "#{cookbook_name}::init"
config = node.run_state[cookbook_name]['config']['network-interface']

if config.nil? || config.empty?
  Chef::Log.warn 'network-interface attribute is empty!'
  config = []
end

# Provide ifdown and ifup
package 'initscripts'

# Create NetworkInterface resource based on attributes
config.each do |dev|
  resource = network_interface dev['device'] do
    action :create
  end
  dev.each do |name, value|
    resource.send(name, value)
  end
end

# Add static routes if needed
routes = node.run_state[cookbook_name]['config']['routes']

routes.each do |iface, iroutes|
  iroutes = ([] << iroutes).flatten
  execute "restart #{iface}" do
    command "ifdown #{iface}; ifup #{iface}"
    action :nothing
  end

  config_path = node.run_state[cookbook_name]['config']['config-path']
  file "#{config_path}/route-#{iface}" do
    content iroutes.join("\n") + "\n"
    notifies :run, "execute[restart #{iface}]", :immediately
  end
end
