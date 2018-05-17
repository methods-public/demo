# logstash_simple cookbook

Very basic LWRP cookbook for installing Logstash via tar.gz (or rpm) on CentOS systems (will add Ubuntu support in future). Service is managed via Systemd scripts provided in the cookbook instead of using runit as per most other cookbooks.

## Pre-requisites

[Java Runtime](https://www.java.com/en/) Logtash requires Java 1.7+ however the resources in this cookbook do not facilitate this. 

This cookbook requires Chef 12.6.0+

## Supported Platforms

This has been tested on CentOS 7.1

## Recipes

This cookbook provides a default recipe to give an example of how to make use of the included Chef resources.

### logtash_simple::default

Installs Logstash 2.1.1 from tar.gz to /usr/local/logstash.

Includes sample syslog input in /etc/logstash/conf.d/logstash_test.conf that listens for syslog messages on TCP/UDP 5000.

Enables and starts service via Systemd with included scripts. 

#### Usage

Include `logstash_simple` in your node's `run_list`:

```

{
  "run_list": [
    "recipe[logstash_simple::default]"
  ]
}

```

## Resources

### logstash_simple_instance

This resource downloads and installs Logstash

Example:
```

logstash_simple_instance 'logstash' do
  package_type 'tarball'
  package_url 'https://download.elastic.co/logstash/logstash/logstash-2.1.1.tar.gz'
  package_checksum '2ea975e16a02b416a5bd9eed5ab280224820f278d54f6e0ec4cccf0d8f5ca610'
  logstash_directory '/usr/local/logstash'
  logstash_version '2.1.1'
  logstash_log_directory '/var/log/logstash'
  logstash_config_directory '/etc/logstash/conf.d'
  logstash_user 'logstash'
  logstash_group 'logstash'
  logstash_heap_size '300M'
  action :create
end

```

### logstash_simple_config

This resource uses the given input, filter and output configuration and generates a logstash config file.

Use multiple logstash_simple_config resources to create multiple config files.

Example:
```

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

```

## logstash_simple_service

This resource manages the Logstash service via Systemd.

The service can be enabled, disabled, stopped or started.

Example:
```

logstash_simple_service 'logstash' do
  action [ :enable, :start ]
end

```

## License and Authors

Author:: Thomas Riley
