Chrony NTP Cookbook
===================

Description
-----------

**[Chrony](https://chrony.tuxfamily.org/)** is a versatile implementation
of the Network Time Protocol (NTP). It can synchronize the system clock
with NTP servers, reference clocks (e.g. GPS receiver), and manual input
using wristwatch and keyboard. It can also operate as an NTPv4 (RFC 5905)
server and peer to provide a time service to other computers in the network.

This cookbook is designed to install and configure Chrony daemon.

Optionnally, it can also configure an exporter script to expose Chrony
metrics following [Prometheus format][1].

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution, tested on:

- RHEL Family 7 (tested on Centos)
- Debian 8

Usage
-----

### Test

This cookbook is fully tested through the installation of a NTP client in
docker hosts. This uses kitchen and docker.

If you run kitchen list, you will see 2 instances, each for a different
operating system:

- chrony-ntp-centos-7: installation of Chrony daemon and metrics exporter
- chrony-ntp-debian-8: same but for debian 8

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb) and
[attributes/exporter.rb](attributes/exporter.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Include `package`, `config`, `service` recipes.

### package

Install **Chrony** using package.

### config

Generate and deploy **Chrony** config: *chrony.conf*.

### service

Create Systemd unit for **Chrony** and make sure service is started.

### exporter

Install metrics exporter *chrony_exporter.sh* as a systemd timer unit.


Resources/Providers
-------------------

None.

Changelog
---------

Available in [CHANGELOG.md](CHANGELOG.md).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Sylvain Arrambourg (<saye@sknss.net>)
- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2017 Make.org

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

[1]: https://prometheus.io/docs/instrumenting/exposition_formats/
