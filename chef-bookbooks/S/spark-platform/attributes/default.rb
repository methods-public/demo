#
# Copyright (c) 2016 Sam4Mobile
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

# Cluster configuration with cluster-search
# Role used by the search to find other nodes of the cluster
default['spark-platform']['role'] = 'spark-platform'
# Hosts of the cluster, deactivate search if not empty
default['spark-platform']['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default['spark-platform']['size'] = 1

# Define who is the (first) master (id 1 is the first node in search result)
default['spark-platform']['master_id'] = 1

# Run a local worker on the masters
default['spark-platform']['master_is_worker'] = true

# Enable standby masters using ZooKeeper
default['spark-platform']['master_ha_with_zk'] = false

# Number of masters
default['spark-platform']['n_of_masters'] = 1

# If master_ha_with_zk is true, we need a Zookeeper cluster
# Use cluster-search to find Zookeeper nodes, see above to understand how to
# configure it
default['spark-platform']['zookeeper']['role'] = 'spark-zookeeper-cluster'
default['spark-platform']['zookeeper']['hosts'] = []
default['spark-platform']['zookeeper']['size'] = 3

# Spark package
default['spark-platform']['version'] = '1.6.2'
spark_version = node['spark-platform']['version']
default['spark-platform']['checksum'] =
  'bddeccec0fb8ac9491cbb4e320467e9263bcc1caf9b45466164f8ae2d97de710'

# Hadoop version
default['spark-platform']['hadoop_version'] = 'hadoop2.6'
hadoop_version = node['spark-platform']['hadoop_version']

default['spark-platform']['artifact'] =
  "spark-#{spark_version}-bin-#{hadoop_version}.tgz"
spark_artifact = node['spark-platform']['artifact']

# Where to get the tarball
default['spark-platform']['mirror_base'] =
  'http://www.mirrorservice.org/sites/ftp.apache.org/spark/'
spark_mirror = node['spark-platform']['mirror_base']

default['spark-platform']['mirror'] =
  "#{spark_mirror}/spark-#{spark_version}/#{spark_artifact}"

default['spark-platform']['github'] = # use to fetch files individually
  'https://raw.githubusercontent.com/apache/spark'

# User and group of spark process
default['spark-platform']['user'] = 'spark'
default['spark-platform']['group'] = 'spark'
# Where to put installation dir
default['spark-platform']['prefix_root'] = '/opt'
# Where to link installation dir
default['spark-platform']['prefix_home'] = '/opt'
# Where to link binaries
default['spark-platform']['prefix_bin'] = '/opt/bin'
# Spark scratch directory
default['spark-platform']['local_dir'] = '/tmp/spark'
# Java package to install by platform
default['spark-platform']['java'] = {
  'centos' => 'java-1.8.0-openjdk-headless'
}
# Should we restart services after config update?
default['spark-platform']['auto_restart'] = false
# Systemd unit file path
default['spark-platform']['unit_path'] = '/etc/systemd/system'

# Spark configuration

# Spark master port to listen
default['spark-platform']['master_port'] = '7077'

default['spark-platform']['spark-env.sh'] = {
  # The following is enforced in config recipe
  # SPARK_LOCAL_DIRS => node['spark-platform']['local_dir']
  # SPARK_MASTER_PORT => node['spark-platform']['master_port']
}
default['spark-platform']['spark-defaults.conf'] = {}

# Log4j configuration, default are loaded directly from github
# you can override any default value by setting the following key.
default['spark-platform']['log4j'] = {}

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default['spark-platform']['package_retries'] = nil
