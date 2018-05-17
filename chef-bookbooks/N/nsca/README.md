# NSCA Installer Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/nsca.svg)](https://supermarket.chef.io/cookbooks/nsca)
[![Build Status](https://secure.travis-ci.org/scopenco/chef-nsca.png?branch=master)](http://travis-ci.org/scopenco/chef-nsca)

## Description

Chef cookbook to install and configure NSCA server/client.

## Requirements

### Chef

* Chef 12 or higher

### Platforms

* Debian 6.X, 7.X
* Ubuntu 14.04
* Red Hat Enterprise Linux (CentOS/Amazon/Scientific/Oracle) 5.X, 6.X
* Fedora 22

**Notes**: This cookbook has been tested on the listed platforms. It may work on other platforms with or without modification.

### Cookbooks

* yum-epel

## Recipes

### server

Configure NSCA server.

### client

Configure NSCA client.

#### Attributes

### platform specific attributes (auto set based on platform)

* `node['nsca']['conf_dir']` - location of the nsca configuration
* `node['nsca']['user']` - NSCA user
* `node['nsca']['group']` - NSCA group
* `node['nsca']['mode']` - chmod configuration file
* `node['nsca']['command_file']` - path to nagios/icinga command pipe
* `node['nsca']['alternate_dump_file']` - path to alternative dump file when pipe is closed

# config file options
* `node['nsca']['pid_file']` - path to pid file
* `node['nsca']['server_address']` - address for NSCA binding
* `node['nsca']['nsca_chroot']` - path to NSCA chroot
* `node['nsca']['server_port']` - NSCA port binding
* `node['nsca']['debug']` - This option determines whether or not debugging messages are logged to the syslog facility.
* `node['nsca']['aggregate_writes']` - This option determines whether or not the nsca daemon will aggregate writes to the external command file for client connections that contain multiple check results.
* `node['nsca']['append_to_file']` - This option determines whether or not the nsca daemon will open the external command file for writing or appending.
* `node['nsca']['max_packet_age']` - This option is used by the nsca daemon to determine when client data is too old to be valid.
* `node['nsca']['password']` - This option is used for password if data bag doesn't exist.
* `node['nsca']['decryption_method']` - This option determines the method by which the nsca daemon will decrypt the packets it receives from the clients.

## Data bags

Password for NSCA can be described in data bag `node['nsca']['data_bag_item']`. There should be an item which name is the value of `node['nsca']['data_bag_item']`.
In our case it is set to data bag "apps" and item to "nsca".

Refer to examples from the "nsca" cookbook: https://github.com/scopenco/chef-nsca/tree/master/test/fixtures/data_bags/apps

## License & Authors
- Author:: Andrei Skopenko <andrey@skopenko.net>

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
