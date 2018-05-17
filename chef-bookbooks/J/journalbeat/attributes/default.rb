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

cookbook_name = 'journalbeat'

# Journalbeat version
default[cookbook_name]['version'] = 'v5.4.1'
version = node[cookbook_name]['version']

# Where to get the binary
default[cookbook_name]['mirror_base'] =
  'https://github.com/mheese/journalbeat/releases/download'
mirror_base = node[cookbook_name]['mirror_base']

binary = "journalbeat-#{node['platform']}"
default[cookbook_name]['mirror'] = "#{mirror_base}/#{version}/#{binary}"

# Root directory
default[cookbook_name]['root_dir'] = '/opt'
root_dir = node[cookbook_name]['root_dir']
link_dir = "#{root_dir}/journalbeat"

# Home directory
default[cookbook_name]['home_dir'] = "#{root_dir}/journalbeat-#{version}"
home_dir = node[cookbook_name]['home_dir']

# Where to put the binary
default[cookbook_name]['bin'] = "#{home_dir}/journalbeat"

# User and group of Journalbeat process
default[cookbook_name]['user'] = 'journalbeat'
default[cookbook_name]['group'] = 'journalbeat'

# Systemd journal group
# If empty, group is not added to journalbeat user
default[cookbook_name]['systemd_journal_group'] = 'systemd-journal'

# Configuration directory
default[cookbook_name]['config_dir'] = home_dir
config_dir = node[cookbook_name]['config_dir']

# Journalbeat configuration file
default[cookbook_name]['config_file'] = 'journalbeat.yml'
config_file = node[cookbook_name]['config_file']

# If journalbeat service is restarted when config file changes
default[cookbook_name]['auto_restart'] = true

# Journalbeat configuration
# Default journalbeat configuration is elasticsearch but this cookbook
# only supports logstash
default[cookbook_name]['config'] = {
  'journalbeat' => {
    'name' => 'journalbeat'
  },
  'output.logstash' => {
    'enabled' => true,
    'hosts' => 'localhost:5044'
  },
  'paths' => {
    'path.home' => home_dir,
    'path.config' => config_dir,
    'path.data' => "#{home_dir}/data",
    'path.logs' => "#{home_dir}/logs"
  },
  'logging.level' => 'warning'
}

# Journalbeat logstash certificate authorities configuration
# If root certificate authorities are available remotely, you can set an
# array of URIs to retrieve them for each output.
# By doing this, ssl configuration will be overrided.
default[cookbook_name]['cas_uris'] = {
  'logstash' => nil
}

# Certs directory
# Only used if cas_uris attribute is set
default[cookbook_name]['certs_dir'] = "#{home_dir}/certs"

# Systemd service unit
default[cookbook_name]['systemd_unit'] = {
  'Unit' => {
    'Description' => 'JournalBeat service',
    'After' => 'network.target'
  },
  'Service' => {
    'Type' => 'simple',
    'User' => node[cookbook_name]['user'],
    'Group' => node[cookbook_name]['group'],
    'Restart' => 'on-failure',
    'WorkingDirectory' => home_dir,
    'ExecStart' => "#{link_dir}/journalbeat -c #{link_dir}/#{config_file}"
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}
