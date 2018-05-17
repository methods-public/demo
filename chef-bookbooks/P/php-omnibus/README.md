# php-omnibus

This cookbook provides a simple solution to installing PHP7+ on CentOS with some pretty
standard packages installed as default

[![Build Status](https://travis-ci.org/usemarkup/chef-php-omnibus.svg?branch=master)](https://travis-ci.org/usemarkup/chef-php-omnibus)

### Testing
```bash
# Install bundler
make install

# Installs all the gems
make bundle

# Runs the kitchen CI test suites
make kitchen

# styling
make style
```

### Default Extensions

- cli
- curl
- opcache
- json
- mbstring
- intl

### Default Configuration

```ini
error_log=syslog

expose_php=0
max_execution_time=5
memory_limit=-1

opcache.enable_cl=0
opcache.fast_shutdown=1
opcache.interned_strings_buffer=64
opcache.max_accelerated_files=25000
opcache.memory_consumption=128

realpath_cache_size=4096k
realpath_cache_ttl=7200
```

### Requirements

It makes use of the following cookbooks

- yum-epel
- yum-ius
- php
- php-fpm

### Chef Tested

- Chef 12.7.2
- Chef 13.1.31

### Operating System Support

- CentOS 6.8+
- CentOS 7+
