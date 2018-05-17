include_attribute "ndb"

#
# Cookbook Name:: kkafka
# Attributes:: default
#

#
# Version of Kafka to install.
#default.kkafka.version = '0.9.0.1'
default.kkafka.version = '0.10.0.0'

#
# Base URL for Kafka releases. The recipes will a download URL using the
# `base_url`, `version` and `scala_version` attributes.
default.kkafka.base_url = 'https://archive.apache.org/dist/kafka'
#default.kkafka.base_url = 'http://snurran.sics.se/hops'
#
# SHA-256 checksum of the archive to download, used by Chef's `remote_file`
# resource.
#default.kkafka.checksum = '7f3900586c5e78d4f5f6cbf52b7cd6c02c18816ce3128c323fd53858abcf0fa1'

# 0.10.0.0
default.kkafka.checksum = '4a9b1949d7b5dbe18efe1486d706f45dfaf0decd88075bb7dd04c8294100e95f'

#
# MD5 checksum of the archive to download, which will be used to validate that
# the "correct" archive has been downloaded.
default.kkafka.md5_checksum = ''

#
# Scala version of Kafka.
default.kkafka.scala_version = '2.10'

#
# Directory where to install Kafka.
default.kkafka.install_dir = '/opt/kafka'

#
# Directory where to install *this* version of Kafka.
# For actual default value see `_defaults` recipe.
default.kkafka.version_install_dir = nil

#
# Directory where the downloaded archive will be extracted to.
default.kkafka.build_dir = ::File.join(Dir.tmpdir, 'kafka-build')

#
# Directory where to store logs from Kafka.
default.kkafka.log_dir = '/var/log/kafka'

#
# Directory where to keep Kafka configuration files. For the
# actual default value see `_defaults` recipe.
default.kkafka.config_dir = nil

#
# JMX port for Kafka.
default.kkafka.jmx_port = 19999

#
# JMX configuration options for Kafka.
default.kkafka.jmx_opts = %w[
  -Dcom.sun.management.jmxremote
  -Dcom.sun.management.jmxremote.authenticate=false
  -Dcom.sun.management.jmxremote.ssl=false
].join(' ')

#
# User for directories, configuration files and running Kafka.
default.kkafka.user = 'kafka'

#
# Should node.kkafka.user and node.kkafka.group be created?
default.kkafka.manage_user = true

#
# Group for directories, configuration files and running Kafka.
default.kkafka.group = 'kafka'

#
# JVM heap options for Kafka.
default.kkafka.heap_opts = '-Xmx4G -Xms1G'

#
# Generic JVM options for Kafka.
default.kkafka.generic_opts = nil

#
# GC log options for Kafka. For the actual default value
# see `_defaults` recipe.
default.kkafka.gc_log_opts = nil

#
# JVM Performance options for Kafka.
default.kkafka.jvm_performance_opts = %w[
  -server
  -XX:+UseCompressedOops
  -XX:+UseParNewGC
  -XX:+UseConcMarkSweepGC
  -XX:+CMSClassUnloadingEnabled
  -XX:+CMSScavengeBeforeRemark
  -XX:+DisableExplicitGC
  -Djava.awt.headless=true
].join(' ')

#
# The type of "init" system to install scripts for. Valid values are currently
# :sysv, :systemd and :upstart.
default.kkafka.init_style = :systemd

#
# The ulimit file limit.
# If this value is not set, Kafka will use whatever the system default is.
# Depending on your system setup you might want to set this to a rather high
# value, or you will most likely run into issues with Kafka simply dying for no
# particular reason as it needs to keep a lot of file handles for socket
# connections and log files for all partitions.
default.kkafka.ulimit_file = 65535

#
# Automatically start kkafka service.
default.kkafka.automatic_start = true

#
# Automatically restart kkafka on configuration change.
# This also implies `automatic_start` even if it's set to `false`.
# The reason for this is that I can see the need for automatically starting
# Kafka if it's not running, but not necessarily restart on configuration
# changes.
default.kkafka.automatic_restart = true

#
# Attribute to set the recipe to used to coordinate Kafka service start
# if nothing is set the default recipe "_coordiante" will be used
# Refer to issue #58 for details.
default.kkafka.start_coordination.recipe = 'kkafka::_coordinate'

#
# Attribute to set the timeout in seconds when stopping the broker
# before sending SIGKILL (or equivalent).
default.kkafka.kill_timeout = 10

#
# `broker` namespace for configuration of a broker.
# Initially set to an empty Hash to avoid having `fetch(:broker, {})`
# statements in helper methods and the alike.
default.kkafka.broker = {}

#
# Root logger level and appender.
default.kkafka.log4j.root_logger = 'INFO, kafkaAppender'

#
# Appender definitions for various Kafka classes.
default.kkafka.log4j.appenders = {
  'kafkaAppender' => {
    type: 'org.apache.log4j.DailyRollingFileAppender',
    date_pattern: '.yyyy-MM-dd',
    file: lazy { %(#{node.kkafka.log_dir}/kafka.log) },
    layout: {
      type: 'org.apache.log4j.PatternLayout',
      conversion_pattern: '[%d] %p %m (%c)%n',
    },
  },
  'stateChangeAppender' => {
    type: 'org.apache.log4j.DailyRollingFileAppender',
    date_pattern: '.yyyy-MM-dd',
    file: lazy { %(#{node.kkafka.log_dir}/kafka-state-change.log) },
    layout: {
      type: 'org.apache.log4j.PatternLayout',
      conversion_pattern: '[%d] %p %m (%c)%n',
    },
  },
  'requestAppender' => {
    type: 'org.apache.log4j.DailyRollingFileAppender',
    date_pattern: '.yyyy-MM-dd',
    file: lazy { %(#{node.kkafka.log_dir}/kafka-request.log) },
    layout: {
      type: 'org.apache.log4j.PatternLayout',
      conversion_pattern: '[%d] %p %m (%c)%n',
    },
  },
  'controllerAppender' => {
    type: 'org.apache.log4j.DailyRollingFileAppender',
    date_pattern: '.yyyy-MM-dd',
    file: lazy { %(#{node.kkafka.log_dir}/kafka-controller.log) },
    layout: {
      type: 'org.apache.log4j.PatternLayout',
      conversion_pattern: '[%d] %p %m (%c)%n',
    },
  },
}

#
# Logger definitions.
default.kkafka.log4j.loggers = {
  'org.IOItec.zkclient.ZkClient' => {
    level: 'INFO',
  },
  'kafka.network.RequestChannel$' => {
    level: 'WARN',
    appender: 'requestAppender',
    additivity: false,
  },
  'kafka.request.logger' => {
    level: 'WARN',
    appender: 'requestAppender',
    additivity: false,
  },
  'kafka.controller' => {
    level: 'INFO',
    appender: 'controllerAppender',
    additivity: false,
  },
  'state.change.logger' => {
    level: 'INFO',
    appender: 'stateChangeAppender',
    additivity: false,
  },
}

default.kkafka.broker.port                                             = 9092


default.kkafka.broker[:log][:retention][:hours]                        = 240
default.kkafka.broker[:log][:retention][:size]                         = "-1"
default.kkafka.broker[:num][:network][:threads]                        = 3
default.kkafka.broker[:num][:io][:threads]                             = 8
default.kkafka.broker[:num][:recovery][:threads][:per][:data][:dir]          = 1
default.kkafka.broker[:num][:replica][:fetchers]                       = 1
default.kkafka.broker[:queued][:max][:requests]                        = 500
default.kkafka.broker[:socket][:send][:buffer][:bytes]                   = 100 * 1024
default.kkafka.broker[:socket][:receive][:buffer][:bytes]                = 100 * 1024
default.kkafka.broker[:socket][:request][:max][:bytes]                   = 100 * 100 * 1024
default.kkafka.broker[:num][:partitions]                             = 1
default.kkafka.broker[:log][:segment][:bytes]                          = 1024 * 1024 * 1024
default.kkafka.broker[:log][:roll][:hours]                             = 24 * 7
default.kkafka.broker[:log][:retention][:hours]                        = 24 * 7
default.kkafka.broker[:log][:retention][:bytes]                        = "-1"
default.kkafka.broker[:log][:retention][:check][:interval][:ms]            = 300000
default.kkafka.broker[:log][:index][:size][:max][:bytes]                   = "10000000"
default.kkafka.broker[:log][:index][:interval][:bytes]                   = "4096"
default.kkafka.broker[:log][:flush][:interval][:messages]                = "9223372036854775807"
default.kkafka.broker[:log][:flush][:scheduler][:interval][:ms]            = 3000
default.kkafka.broker[:log][:flush][:interval][:ms]                      = 3000
default.kkafka.broker[:leader][:imbalance][:check][:interval][:seconds]    = 300
default.kkafka.broker[:leader][:imbalance][:per][:broker][:percentage]     = 10
default.kkafka.broker[:log][:dir]                                    = "/tmp/kafka-logs"
default.kkafka.broker[:log][:flush][:offset][:checkpoint][:interval][:ms]    = 60000
default.kkafka.broker[:queued][:max][:requests]                        = 500
default.kkafka.broker[:quota][:consumer][:default]                     = 9223372036854775807
default.kkafka.broker[:quota][:producer][:default]                     = 9223372036854775807
default.kkafka.broker[:replica][:fetch][:max][:bytes]                    = 1048576
default.kkafka.broker[:replica][:fetch][:min][:bytes]                    = 1
default.kkafka.broker[:replica][:fetch][:wait][:max][:ms]                  = 500
default.kkafka.broker[:replica][:high][:watermark][:checkpoint][:interval][:ms]    = 5000
default.kkafka.broker[:replica][:lag][:time][:max][:ms]                    = 10000
default.kkafka.broker[:replica][:socket][:receive][:buffer][:bytes]        = 65536
default.kkafka.broker[:replica][:socket][:timeout][:ms]                  = 30000
default.kkafka.broker[:request][:timeout][:ms]                         = 30000
default.kkafka.broker[:message][:max][:bytes]                          = "1000012"
default.kkafka.broker[:default][:replication][:factor]                 = 1
default.kkafka.broker[:log][:cleaner][:enable]                         = "true"
default.kkafka.broker[:log][:cleaner][:io][:buffer][:load][:factor]    = "0.9"
# values are: PLAINTEXT, SSL, SASL_PLAINTEXT, SASL_SSL
default.kkafka.broker[:security][:inter][:broker][:protocol]           = "PLAINTEXT"
# required, requested, none
default.kkafka.broker[:ssl][:client][:auth]                            = "requested"
default.kkafka.broker[:ssl][:keystore][:location]                      = "#{node.kagent.certs_dir}/keystores/node_server_keystore.jks"
default.kkafka.broker[:ssl][:keystore][:password]                      = "adminpw"
#= "#{node.hopsworks.admin.password}"
default.kkafka.broker[:ssl][:truststore][:location]                    = "#{node.kagent.certs_dir}/keystores/node_server_truststore.jks"
default.kkafka.broker[:ssl][:truststore][:password]                    = "adminpw"
  # "#{node.hopsworks.admin.password}"

# TODO - HopsWorks implementations needed
default.kkafka.broker[:authorizer][:class][:name]                      = "io.hops.kafka.HopsAclAuthorizer"
default.kkafka.broker[:authorizer][:download_url]                      = ""
default.kkafka.broker[:ssl][:endpoint][:identification][:algorithm]    = ""
default.kkafka.broker[:principal][:builder][:class]                    = "io.hops.kafka.HopsPrincipalBuilder"
default.kkafka.broker[:allow][:everyone][:if][:no][:acl][:found]       = "false"
default.kkafka.broker[:delete][:topic][:enable]                        = "true"

default.kkafka.broker[:zookeeper][:synctime][:ms]                      = 6000
default.kkafka.broker[:zookeeper][:connectiontimeout][:ms]             = 60000
default.kkafka.broker[:zookeeper][:sessiontimeout][:ms]                = 6000
default.kkafka.broker[:zookeeper][:synctime][:ms]                      = 2000
default.kkafka.broker[:zookeeper][:session][:timeout][:ms]             = 6000
default.kkafka.broker[:zookeeper][:set][:acl]                          = "false"


default[:kkafka][:offset_monitor][:version]                            = "0.2.1"
default[:kkafka][:offset_monitor][:url]                                = "http://snurran.sics.se/hops/KafkaOffsetMonitor-assembly-" + node[:kkafka][:offset_monitor][:version] + ".jar"
default[:kkafka][:offset_monitor][:port]                               = "11111"
