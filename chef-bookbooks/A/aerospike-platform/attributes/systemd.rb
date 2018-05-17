#
# Copyright (c) 2016 Sam4Mobile, 2018 Make.org
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

cookbook_name = 'aerospike-platform'
root_prefix = node[cookbook_name]['prefix_root']
default[cookbook_name]['asd_options'] =
  "--config-file #{root_prefix}/aerospike/aerospike.conf"
asd_options = node[cookbook_name]['asd_options']

# Configure systemd unit with options
default[cookbook_name]['systemd_unit'] = {
  'Unit' => {
    'Description' => 'Aerospike Server',
    'After' => 'network.target',
    'Wants' => 'network.target'
  },
  'Service' => {
    'Type' => 'forking',
    'LimitNOFILE' =>
      node[cookbook_name]['config']['service']['proto-fd-max'],
    'User' => node[cookbook_name]['user'],
    'Group' => node[cookbook_name]['group'],
    'Restart' => 'on-failure',
    'ExecStart' =>
       "#{root_prefix}/aerospike/bin/asd #{asd_options}"
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}
