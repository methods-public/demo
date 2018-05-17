
# Copyright (c) 2016-2017 Sam4Mobile, 2017 Make.org
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

cookbook_name = 'consul-platform'

# Cluster configuration with cluster-search
# The nodes found will be the servers
# It is used to populate the server and retry_join options in the config file
# Role used by the search to find other nodes of the cluster
default[cookbook_name]['role'] = cookbook_name
# Hosts of the cluster, deactivate search if not empty
default[cookbook_name]['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default[cookbook_name]['size'] = 1

# consul version
default[cookbook_name]['version'] = '0.8.3'
version = node[cookbook_name]['version']
# package sha256 checksum
default[cookbook_name]['checksum'] =
  'f894383eee730fcb2c5936748cc019d83b220321efd0e790dae9a3266f5d443a'

# Where to get the zip file
binary = "consul_#{version}_linux_amd64.zip"
default[cookbook_name]['mirror'] =
  "https://releases.hashicorp.com/consul/#{version}/#{binary}"

# User and group of consul process
default[cookbook_name]['user'] = 'consul'
default[cookbook_name]['group'] = 'consul'

# Where to put installation dir
default[cookbook_name]['prefix_root'] = '/opt'
# Where to link installation dir
default[cookbook_name]['prefix_home'] = '/opt'
# Where to link binaries
default[cookbook_name]['prefix_bin'] = '/opt/bin'

# Data directory
default[cookbook_name]['data_dir'] =
  "#{node[cookbook_name]['prefix_home']}/consul/data"

# Configuration directory
default[cookbook_name]['config_dir'] =
  "#{node[cookbook_name]['prefix_home']}/consul/etc"

# Consul configuration files
default[cookbook_name]['main_config'] = 'consul.json'
# Format : name of the file => configuration it contains
default[cookbook_name]['config'] = {
  node[cookbook_name]['main_config'] => { # Main configuration
    'data_dir' => node[cookbook_name]['data_dir'],
    # 'server' => true if included in the search or hosts
    # 'retry_join' => will be filled from search
  }
}

# Consul daemon options, used to create the ExecStart option in service
# Uou should modify the configuration file instead of the CLI options
default[cookbook_name]['cli_opts'] = {
  'config-dir' => node[cookbook_name]['config_dir']
}

# Systemd service unit, include config
default[cookbook_name]['systemd_unit'] = {
  'Unit' => {
    'Description' => 'consul agent',
    'After' => 'network.target'
  },
  'Service' => {
    'Type' => 'simple',
    'User' => node[cookbook_name]['user'],
    'Group' => node[cookbook_name]['group'],
    'Restart' => 'on-failure',
    'ExecStart' => 'TO_BE_COMPLETED'
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
