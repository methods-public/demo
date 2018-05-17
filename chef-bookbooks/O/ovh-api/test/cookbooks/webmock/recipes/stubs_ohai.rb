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
include_recipe "#{cookbook_name}::stubs_init"

# Useful variables
url = node['ovh-api']['api-url']
service_name = 'default-ovh.kitchen'
dedicated = "#{url}/dedicated/server/#{service_name}"

# Stubs definition for firewall recipe
stub_request(:get, "#{dedicated}/specifications/hardware").to_return(
  body: <<-JSON,
    {
      "memorySize": {
        "unit": "MB",
        "value": 262144
      },
      "processorArchitecture": "x86_64",
      "diskGroups": [
        {
          "numberOfDisks": 12,
          "diskType": "SSD",
          "diskSize": {
            "unit": "GB",
            "value": 480
          },
          "raidController": "MegaRaid 9271-4i"
        }
      ],
      "defaultHardwareRaidType": "raid10",
      "processorName": "E5-2660v3",
      "description": "Serveur Infrastructure BIG-HG 2U (max 12 disques)",
      "numberOfProcessors": 2,
      "usbKeys": null,
      "coresPerProcessor": 10,
      "defaultHardwareRaidSize": {
        "unit": "GB",
        "value": 2880
      },
      "motherboard": "X10DRH-iT"
    }
  JSON
  status: 200
)
