#
# Copyright (c) 2017 Sam4Mobile, 2017-2018 Make.org
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

cookbook_name = 'cassandra-platform'

node_attr = node[cookbook_name]

# Configure systemd unit with options
default[cookbook_name]['systemd_unit'] = {
  'Unit' => {
    'Description' => 'Cassandra node',
    'After' => 'network.target',
    'Wants' => 'network.target'
  },
  'Service' => {
    'Type' => 'simple',
    'User' => node[cookbook_name]['user'],
    'Group' => node[cookbook_name]['group'],
    'LimitNOFILE' => 65_535,
    'LimitMEMLOCK' => 'infinity',
    'Restart' => 'on-failure',
    'ExecStart' => "#{node_attr['prefix_home']}/cassandra/bin/cassandra -f"
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}
