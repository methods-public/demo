#
# Copyright (c) 2015-2016 Sam4Mobile
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

# Storm package
default['storm-platform']['version'] = '1.0.1'
default['storm-platform']['checksum'] =
  '1574c08d8cfb6bc7509c78871e98a535f1386d6ca50fa71c880c39e8800620bf'
default['storm-platform']['mirror'] =
  'http://apache.mirrors.ovh.net/ftp.apache.org/dist/storm'
default['storm-platform']['github'] = # use to fetch files individually
  'https://raw.githubusercontent.com/apache/storm'

# Storm installation
default['storm-platform']['user'] = 'storm'
default['storm-platform']['prefix_root'] = '/opt'
default['storm-platform']['prefix_home'] = '/opt'
default['storm-platform']['prefix_bin'] = '/opt/bin'
default['storm-platform']['log_dir'] = '/var/opt/storm/log'
default['storm-platform']['data_dir'] = '/var/opt/storm/lib'
default['storm-platform']['java'] = {
  'centos' => 'java-1.8.0-openjdk-headless'
}
default['storm-platform']['auto_restart'] = true
default['storm-platform']['unit_path'] = '/etc/systemd/system'

# Cluster configuration
default['storm-platform']['role'] = 'storm-platform'
default['storm-platform']['hosts'] = [] # Use search when empty
default['storm-platform']['size'] = 1

# Set Nimbus node by its id
default['storm-platform']['nimbus_id'] = 1 # Between 1 and cluster size
default['storm-platform']['n_of_nimbus'] = 1 # Number of nimbus (for HA)
default['storm-platform']['slots_ports'] = [] # Default ports if empty

# Zookeeper configuration
default['storm-platform']['zookeeper']['role'] = 'zookeeper-storm'
default['storm-platform']['zookeeper']['hosts'] = [] # Use search when empty
default['storm-platform']['zookeeper']['size'] = 1

# Storm configuration
# You can use erb notation with chef variables
default['storm-platform']['config'] = {
  'storm.local.dir' => node['storm-platform']['data_dir']

  # These may optionally be filled in:
  # List of custom serializations
  # 'topology.kryo.register' => [
  #   'org.mycompany.MyType',
  #   {'org.mycompany.MyType2' => 'org.mycompany.MyType2Serializer'}
  # ],
  # List of custom kryo decorators
  # 'topology.kryo.decorators' => [
  #   'org.mycompany.MyDecorator'
  # ],
  # Metrics Consumers
  # 'topology.metrics.consumer.register' => [
  #   {
  #     'class' => 'backtype.storm.metric.LoggingMetricsConsumer',
  #     'parallelism.hint' => 1
  #   },
  #   {
  #     'class' => 'org.mycompany.MyMetricsConsumer',
  #     'parallelism.hint' => 1,
  #     'argument' => [
  #       {'endpoint' => 'metrics-collector.mycompany.org'}
  #     ]
  #   }
  # ]
}

# Log4j2 configuration, default are loaded directly from xml files located
# in Storm official archive, you can override any default value by setting
# the following two keys. Note: 'configuration' root is not needed
default['storm-platform']['log4j']['cluster'] = {}
default['storm-platform']['log4j']['worker'] = {}
