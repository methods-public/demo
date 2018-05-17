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

# Cluster configuration with cluster-search
# Role used by the search to find other nodes of the cluster
default[cookbook_name]['role'] = cookbook_name
# Hosts of the cluster, deactivate search if not empty
default[cookbook_name]['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default[cookbook_name]['size'] = 1

# Define who is the (first) seed (id 1 is the first node in search result)
default[cookbook_name]['seed_id'] = 1

# Number of nodes acting as seeds for the cluster
default[cookbook_name]['n_of_seeds'] = 1

# consul version
default[cookbook_name]['version'] = '3.11.2'
version = node[cookbook_name]['version']

# package sha256 checksum
default[cookbook_name]['checksum'] =
  'e922770ad95d5288d42442c3cfa1475938597b38418b7be5c4234a9de388c720'

# Where to get the archive
binary = "apache-cassandra-#{version}-bin.tar.gz"
default[cookbook_name]['url'] =
  "http://www-eu.apache.org/dist/cassandra/#{version}/#{binary}"

# Define user/group running Cassandra
default[cookbook_name]['user'] = 'cassandra'
default[cookbook_name]['group'] = 'cassandra'

# Java package to install by platform
default[cookbook_name]['java'] = {
  'centos' => 'java-1.8.0-openjdk-headless',
  'version' => 'latest'
}

# Where to put installation dir
default[cookbook_name]['prefix_root'] = '/opt'
# Where to link installation dir
default[cookbook_name]['prefix_home'] = '/opt'
# Where to link binaries
default[cookbook_name]['prefix_bin'] = '/opt/bin'
# Cassandra data dir (distribution default is in install dir which is bad)
# Is a symbolic dir from $CASSANDRA_HOME/data to include data usage
default[cookbook_name]['data_dir'] = '/var/opt/cassandra'
# Cassandra configuration file
default[cookbook_name]['config_dir'] =
  "#{node[cookbook_name]['prefix_home']}/cassandra/conf"
# Cassandra bin dir
default[cookbook_name]['bin_dir'] =
  "#{node[cookbook_name]['prefix_home']}/cassandra/bin"

# Filling configuration files
# - Format : name of the file => configuration it contains
#   Formatting will be determined by file extension (.yaml/.properties/...)
#   It may be merged with default file (look at 'download_default' attribute)
#   5 formats are defined: properties, yaml, xml, options and other/none
# - Basically, everything is a hash, for file with no extension (or extension
#   options), only values are taken into account, key is just there to allow
#   override (and empty values are ignored).
default[cookbook_name]['config'] = {
  'cassandra.yaml' => {
    'listen_address' => node['ipaddress'], # official default is localhost
    'seed_provider' => '!!! WILL BE REPLACED IN CONFIG RECIPE !!!'
  }
}

# For the following filename pattern, download file default from git and merge
# it with attribute config
# - Set a key to false and add new patterns to modify this behavior
# - Merge is not possible for file without extension (it will be ignored)
# - For options file, each non-comment/empty line will be read as a
#   key => value where both key and value are the line itself. This allows the
#   override of a single value by using the same key and a different value (or
#   empty to remove it)
# - For yaml and xml, merge is done recursively on hashes
default[cookbook_name]['download_default'] = {
  '.+\.properties' => true,
  '.+\.yaml' => true,
  '.+\.xml' => true,
  'jvm\.options' => true
}

# Gitweb repository of cassandra (to download default config)
default[cookbook_name]['git'] =
  'https://git1-us-west.apache.org/repos/asf?p=cassandra.git'

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
