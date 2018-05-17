#
# Copyright (c) 2017-2018 Make.org
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

# Where to put the exporter script
default[cookbook_name]['exporter']['install_dir'] = '/opt/bin'
exporter_file =
  "#{node[cookbook_name]['exporter']['install_dir']}/cassandra_exporter.sh"

# Where to put the exported metrics
default[cookbook_name]['exporter']['metrics_dir'] = '/var/opt/node_exporter'
metrics_file =
  "#{node[cookbook_name]['exporter']['metrics_dir']}/cassandra.prom"

# Exporter systemd service unit
default[cookbook_name]['exporter']['unit'] = {
  'Unit' => {
    'Description' => 'Cassandra exporter service',
    'After' => 'network.target'
  },
  'Service' => {
    'Type' => 'simple',
    'ExecStart' => "/bin/bash -c '#{exporter_file} > #{metrics_file}'"
  }
}

# Exporter systemd timer unit
default[cookbook_name]['exporter']['timer_unit'] = {
  'Unit' => {
    'Description' => 'Cassandra exporter timer'
  },
  'Timer' => {
    'OnCalendar' => '*:0/2'
  },
  'Install' => {
    'WantedBy' => 'timers.target'
  }
}
