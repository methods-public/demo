fabio cookbook
===================

[![Build Status](https://travis-ci.org/ptqa/chef-fabio.svg?branch=master)](https://travis-ci.org/ptqa/chef-fabio)
[![Cookbook Version](https://img.shields.io/cookbook/v/fabio.svg)](https://supermarket.chef.io/cookbooks/fabio)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Chef cookbook to install & configure [fabio](https://github.com/eBay/fabio).

Requirements
------------

- Chef Client 11.x or better

### Platforms

* Centos
* Ubuntu
* Debian


### Dependent Cookbooks

- [poise-service-runit](https://github.com/poise/poise-service)

# Attributes
This cookbook is attribute driven. List of attributes that you can change:

* `node['fabio']['release_url']`     - URL of release to install. Check [fabio github](https://github.com/eBay/fabio/releases) for available releases (cookbook tries to install '1.1.4' by default).
* `node['fabio']['conf_dir']`        - Configuration directory (default '/etc/fabio/')
* `node['fabio']['config']`          - Set config file options via hash of attributes `{'proxy.addr' => ':9999'}` becomes `proxy.addr = :9999` (default '{}')
* `node['fabio']['log_dir']`         - Logs directory (default '/var/log/fabio/')
* `node['fabio']['init_style']`      - explicitly set the init system used (`systemd`, `runit`, `sysvinit`, `upstart` or `inittab`). Default is `runit`.

# Usage

```ruby
include_recipe [fabio::default]
```

Testing
-----

[Kitchen](http://kitchen.ci) tests via [busser-serverspec](https://github.com/test-kitchen/busser-serverspec):
* `kitchen test`

License & Authors
-----------------
- Author:: [@ptqa](https://github.com/ptqa)

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
