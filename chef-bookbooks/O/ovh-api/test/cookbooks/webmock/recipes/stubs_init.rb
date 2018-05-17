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

# Include init to load all dependencies
include_recipe "#{cookbook_name}::init"

# Useful variables
url = node['ovh-api']['api-url']
addresses = node['network']['interfaces']['eth0']['addresses']
ip = addresses.select { |_addr, info| info['family'] == 'inet' }.keys.first

# Stubs definition for init recipe
stub_request(:get, "#{url}/ip/#{ip}%2F32").to_return(
  body: <<-JSON,
    {
      "routedTo": {
        "serviceName": "default-ovh.kitchen"
      },
      "ip": "#{ip}/32",
      "type": "dedicated"
    }
  JSON
  status: 200
)

stub_request(:get, "#{url}/ip/1.2.3.4%2F32").to_return(
  body: <<-JSON,
    {
      "message": "The requested object (ip = 1.2.3.4/32) does not exist"
    }
  JSON
  status: 404
)
