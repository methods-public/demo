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

# Cluster configuration with cluster-search
# Role used by the search to find other nodes of the cluster
default[cookbook_name]['role'] = cookbook_name
# Hosts of the cluster, deactivate search if not empty
default[cookbook_name]['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default[cookbook_name]['size'] = 1

# aerospike package
default[cookbook_name]['version'] = '3.10.0.3'
aerospike_version = node[cookbook_name]['version']
default[cookbook_name]['checksum'] =
  '08274802addc22c25df4cd3841bdd72bfe1845aa2d623b1190d05c4ab997bfd7'

# Where to get the tarball
default[cookbook_name]['mirror_base'] =
  'https://www.aerospike.com/artifacts/aerospike-server-community'
aerospike_mirror = node[cookbook_name]['mirror_base']
default[cookbook_name]['package'] =
  "aerospike-server-community-#{aerospike_version}.tar.gz"
aerospike_package = node[cookbook_name]['package']
default[cookbook_name]['mirror'] =
  "#{aerospike_mirror}/#{aerospike_version}/#{aerospike_package}"

# User and group of aerospike
default[cookbook_name]['user'] = 'aerospike'
default[cookbook_name]['group'] = 'aerospike'
# Where to put installation dir
default[cookbook_name]['prefix_root'] = '/opt'
# Where to link installation dir
default[cookbook_name]['prefix_home'] = '/opt'
# Where to link binaries
default[cookbook_name]['prefix_bin'] = '/opt/bin'
