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

# Read secret keys from encrypted the specified data bag
keys = data_bag_item(
  node[cookbook_name]['secrets-data_bag'],
  node[cookbook_name]['ovh-keys']
)

# Depends on ovh-rest gem
chef_gem 'ovh-rest' do
  compile_time true
end
require 'ovh/rest'

# Create ::OVH::REST object and put it in node.run_state
ovh_client = ::OVH::REST.new(
  keys['app_key'],
  keys['app_secret'],
  keys['consumer_key'],
  node[cookbook_name]['api-url']
)
node.run_state['ovh_client'] = ovh_client

# Get service name by its primary ip (assigned by OVH)
# Check all ipv4, stop at the first recognized by OVH

# Load our library, get all ifaces with an ipv4, sorted by iface name
::Chef::Recipe.send(:include, ::OVHAPI)
candidates = ifipv4(ifaddrswithipv4)

ovh_iface = nil
ovh_ip = nil
ip_info = nil
candidates.each do |iface, addr|
  begin
    ip_info = ovh_client.get("/ip/#{addr}%2F32")
    ovh_iface = iface
    ovh_ip = addr
    break
  rescue ::OVH::RESTError
    nil
  end
end

# If we found a valid IP, we save it and its interface in the run_state
raise 'No valid IP founded, is this an OVH dedicated server?' if ovh_ip.nil?
node.run_state['ovh_ip'] = ovh_ip
node.run_state['ovh_iface'] = ovh_iface

# Then we fetch the service name in ip info, we also save it in the run_state
unless ip_info['ip'] == "#{ovh_ip}/32"
  raise "Invalid IP: requested #{ovh_ip}/32, got #{ip_info['ip']}"
end
unless ip_info['type'] == 'dedicated' || ip_info['type'] == 'cloud'
  raise "Wrong ip type: need \"dedicated\" or \"cloud\" got #{ip_info['type']}"
end

node.run_state['ovh_service_name'] = ip_info['routedTo']['serviceName']
node.run_state['ovh_ip_type'] = ip_info['type']
