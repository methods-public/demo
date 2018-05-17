#
# Copyright (c) 2015-2016 Sam4Mobile, 2017 Make.org
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

# Set cookbook_name macro
cookbook_name = 'zookeeper-platform'

# Zookeeper package
default[cookbook_name]['version'] = '3.4.10'
default[cookbook_name]['checksum'] =
  '7f7f5414e044ac11fee2a1e0bc225469f51fb0cdf821e67df762a43098223f27'
default[cookbook_name]['mirror'] =
  'http://archive.apache.org/dist/zookeeper/'

# Zookeeper installation
# User and group of zookeeper process
default[cookbook_name]['user'] = 'zookeeper'
# Where to put installation dir
default[cookbook_name]['prefix_root'] = '/opt'
# Where to link installation dir
default[cookbook_name]['prefix_home'] = '/opt'
# Where to link binaries
default[cookbook_name]['prefix_bin'] = '/opt/bin'
# Log directory
default[cookbook_name]['log_dir'] = '/var/opt/zookeeper/log'
# Data directory
default[cookbook_name]['data_dir'] = '/var/opt/zookeeper/lib'
# Java package to install by platform
default[cookbook_name]['java'] = {
  'centos' => 'java-1.8.0-openjdk-headless'
}
# Restart Zookeeper service if a configuration file change
default[cookbook_name]['auto_restart'] = true
# Systemd unit file path
default[cookbook_name]['unit_path'] = '/etc/systemd/system'

# Cluster configuration
# Role used by the search to find other nodes of the cluster
default[cookbook_name]['role'] = cookbook_name
# Hosts of the cluster, deactivate search if not empty
default[cookbook_name]['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default[cookbook_name]['size'] = 3

# Zookeeper configuration
default[cookbook_name]['config'] = {
  'clientPort' => 2181,
  'dataDir' => node[cookbook_name]['data_dir'],
  'tickTime' => 2000,
  'initLimit' => 5,
  'syncLimit' => 2
}

# JVM configuration
# {key => value} which gives "key=value" or just "key" if value is nil
default[cookbook_name]['jvm_opts'] = {
  '-Dcom.sun.management.jmxremote' => nil,
  '-Dcom.sun.management.jmxremote.authenticate' => false,
  '-Dcom.sun.management.jmxremote.ssl' => false,
  '-Dcom.sun.management.jmxremote.port' => 2191,
  '-Djava.rmi.server.hostname' => node['fqdn']
}

# log4j configuration
default[cookbook_name]['log4j'] = {
  'log4j.rootLogger' => 'INFO, ROLLINGFILE',
  'log4j.appender.CONSOLE' => 'org.apache.log4j.ConsoleAppender',
  'log4j.appender.CONSOLE.Threshold' => 'INFO',
  'log4j.appender.CONSOLE.layout' => 'org.apache.log4j.PatternLayout',
  'log4j.appender.CONSOLE.layout.ConversionPattern' =>
    '%d{ISO8601} [myid:%X{myid}] - %-5p [%t:%C{1}@%L] - %m%n',
  'log4j.appender.ROLLINGFILE' => 'org.apache.log4j.RollingFileAppender',
  'log4j.appender.ROLLINGFILE.Threshold' => 'INFO',
  'log4j.appender.ROLLINGFILE.File' =>
    "#{node[cookbook_name]['log_dir']}/zookeeper.log",
  'log4j.appender.ROLLINGFILE.MaxFileSize' => '10MB',
  'log4j.appender.ROLLINGFILE.layout' => 'org.apache.log4j.PatternLayout',
  'log4j.appender.ROLLINGFILE.layout.ConversionPattern' =>
    '%d{ISO8601} [myid:%X{myid}] - %-5p [%t:%C{1}@%L] - %m%n',
  'log4j.appender.TRACEFILE' => 'org.apache.log4j.FileAppender',
  'log4j.appender.TRACEFILE.Threshold' => 'TRACE',
  'log4j.appender.TRACEFILE.File' =>
    "#{node[cookbook_name]['log_dir']}/zookeeper_trace.log",
  'log4j.appender.TRACEFILE.layout' => 'org.apache.log4j.PatternLayout',
  'log4j.appender.TRACEFILE.layout.ConversionPattern' =>
    '%d{ISO8601} [myid:%X{myid}] - %-5p [%t:%C{1}@%L][%x] - %m%n'
}

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
