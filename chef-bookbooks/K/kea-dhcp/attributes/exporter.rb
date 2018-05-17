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

cookbook_name = 'kea-dhcp'

# Where to put the DHCP client exporter script
default[cookbook_name]['exporter']['install_dir'] = '/opt/bin'

# Where to put the DHCP client exported metrics
default[cookbook_name]['exporter']['metrics_dir'] = '/var/opt/node_exporter'

# DHCP client exporter systemd service unit
default[cookbook_name]['exporter']['unit'] = {
  'Unit' => {
    'Description' => 'DHCP client exporter service',
    'After' => 'network.target'
  },
  'Service' => {
    'Type' => 'simple',
    'ExecStart' => '!!! WILL BE REPLACED IN EXPORTER RECIPE !!!'
  }
}

# DHCP client exporter systemd timer unit
default[cookbook_name]['exporter']['timer_unit'] = {
  'Unit' => {
    'Description' => 'DHCP client exporter timer'
  },
  'Timer' => {
    'OnCalendar' => '*:0/5'
  },
  'Install' => {
    'WantedBy' => 'timers.target'
  }
}
