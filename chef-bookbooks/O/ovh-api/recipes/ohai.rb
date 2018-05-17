#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
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

# Include init, necessary to get ovh_client
include_recipe "#{cookbook_name}::init"

# Get ovh information filled by init recipe
ovh_client = node.run_state['ovh_client']
ovh_service_name = node.run_state['ovh_service_name']
ovh_ip = node.run_state['ovh_ip']
ovh_iface = node.run_state['ovh_iface']
ovh_ip_type = node.run_state['ovh_ip_type']

# Create hint with general informations fetched from OVH API
ohai_hint 'ovh-general' do
  content(
    'service_name' => ovh_service_name,
    'type' => ovh_ip_type,
    'primary_ip' => ovh_ip,
    'primary_iface' => ovh_iface
  )
end

case ovh_ip_type
when 'dedicated'
  # Create hint with hardware informations, only for dedicated servers
  url = "/dedicated/server/#{ovh_service_name}/specifications/hardware"
  hardware = ovh_client.get(url)

  ohai_hint 'ovh-hardware' do
    content hardware
  end
end

# Install Ohai plugin 'ovh'
ohai_plugin 'ovh' do
  resource :template
end
