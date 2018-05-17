#
# Cookbook Name:: logstash
# Recipe:: default
#

logtash_config = '/etc/logstash/conf.d'

node.default['java']['jdk_version'] = '8'
include_recipe 'java'

logstash_simple_instance 'logstash' do
  package_type 'tarball'
  package_url 'https://download.elastic.co/logstash/logstash/logstash-2.1.1.tar.gz'
  package_checksum '2ea975e16a02b416a5bd9eed5ab280224820f278d54f6e0ec4cccf0d8f5ca610'
  logstash_directory '/usr/local/logstash'
  logstash_version '2.1.1'
  logstash_log_directory '/var/log/logstash'
  logstash_config_directory logtash_config
  logstash_user 'logstash'
  logstash_group 'logstash'
  logstash_heap_size '300M'
  action :create
end

logstash_simple_config 'logstash' do
  input <<-EOF
  input {
    tcp {
      port => 5000
      type => syslog
    }
    udp {
      port => 5000
      type => syslog
    }
  }
  EOF
  filter <<-EOF
  filter {

  }
  EOF
  output <<-EOF
  output {

  }
  EOF
  path logtash_config
  name 'logstash_test.conf'
  action :create
end

logstash_simple_service 'logstash' do
  action [ :enable, :start ]
end