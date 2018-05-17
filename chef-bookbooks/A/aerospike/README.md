# aerospike cookbook

This cookbook installs and configures the Aerospike Server with a default
in-memory namespace called "test". It is highly recommended to modify the
attributes according to your environment and Aerospike recommendations.

## Enterprise edition

This cookbook supports installing Aerospike's Enterprise Edition, but you will
have to override some attributes. The recommended way is to use a wrapper
cookbook and define the following:

```ruby
default['aerospike']['server']['edition']         = 'enterprise'
default['aerospike']['server']['pkg']['url']      = 'https://www.aerospike.com/enterprise/download/server/VERSION/artifact/PLATFORM'
default['aerospike']['server']['pkg']['headers']  = { 'Authorization' => "Basic #{Base64.encode64('USER:PASSWORD').strip}" }
default['aerospike']['server']['pkg']['checksum'] = 'SHA256CHECKSUM'
```

## Requirements

The cookbook is tested on the following platforms:

* Centos 6, 7
* Debian 7, 8
* Ubuntu 12.04, 14.04, 16.04

## Recipes

### default

This recipe will call: install, conf, service (in that order).

### install

This recipe will download the Aerospike Server archive, extract it, and install
the rpm or deb package (depending on the platform).

### service

This recipe will declare the Aerospike Server service (it is installed and
configured by the package).

### conf

This recipe will generate tne Aerospike Server configuration from attributes.
