Kea DHCP
========

Description
-----------

Install and configure [**ISC Kea**](https://www.isc.org/kea/), a Modern Open
Source DHCPv4 & DHCPv6 Server.

Can also:
- configure network interfaces by the use of cookbook
[**network_interfaces_v2**][ni], for instance to
set a static address at the server and dhcp for the clients.

- configure an exporter script to expose DHCP client metrics
following [Prometheus format][ef]. Only IP lifetime validity
of dynamically assigned network interface currently reported.

Requirements
------------

### Cookbooks

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

- RHEL Family 7, tested on Centos

It should be easy to add a new platform.

Usage
-----

### Easy Setup

Add `recipe[kea-dhcp::server]` in your run-list to install and configure
**Kea**. Configuration will be fetched from attributes
`node['kea-dhcp']['kea-conf']`. It directly follows '/etc/kea/kea.conf' format.
See official documentation for more help.

Add `recipe[kea-dhcp::client]` to install a dhcp client.

Add `recipe[kea-dhcp::network_interface]` to configure your network
interfaces. Configuration is fetched from attributes
`node['kea-dhcp']['network-interface']` which should match those of
provider [**network_interface**][ni].

To see examples, look at [.kitchen.yml](.kitchen.yml).

### Test

This cookbook is fully tested through the installation of a server and a node
in docker hosts. This uses kitchen, docker and some monkey-patching.

If you run kitchen list, you will see 2 suites, Each corresponds to a different
server:

- server-centos-7: Kea server listening on eth1
- node-centos-7: generic node with eth1 configured in dhcp

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

### Specific configuration (client or server)

To allow clients and servers to share a same role, it is possible to define
specific configuration keys applicable to one of the status (client or server).

Specific configurations can be any of the attributes defined in
[attributes/default.rb](attributes/default.rb) but in either "client-config"
or "server-config" sub-tree.

A node is declared as server if its FQDN is included in attribute
`node['kea-dhcp']['servers']` defined as an array. Else, it is considered
as a client.

Recipes
-------

### default

Call **init** and then, following the node status, call **client** or
**server** recipe.

### init

Determine if the current machine is a server or a client by looking if current
fqdn is included in `node['kea-dhcp']['servers']` (empty by default). Write the
result in `run_state['kea-dhcp']['status']`. Then merge default and specific
(client or server) configurations and store the result in
`run_state['kea-dhcp']['config']`.

Note: **init** is included in all recipes.

### client

Install **dhclient** package.

### server

Meta recipe which includes **server_install**, **server_config** and
**server_service**.

### server\_install

Install **Kea** by from EPEL repository.

### server\_config

Set `/etc/kea/kea.conf` from attributes `kea-conf`.

### server\_service

Start and enable Kea services (like dhcp4, dhcp6, dhcp-ddns) if enabled in
attributes `services`.

### network\_interface

Call **network_interface_rhel** provider based on
attributes `node['kea-dhcp']['network-interface']`.
See [.kitchen.yml](.kitchen.yml) and cookbook
[**network_interface_v2**][ni] for more information.

Create static routes based on `node['kea-dhcp']['routes']` attribute.

### exporter

Install metrics exporter dhcp-client_exporter.sh as a systemd timer unit.

Resources/Providers
-------------------

None.

Changelog
---------

Available in [CHANGELOG](CHANGELOG).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2015-2016 Sam4Mobile, 2017 Make.org

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

[ni]: https://supermarket.chef.io/cookbooks/network_interfaces_v2
[ef]: https://prometheus.io/docs/instrumenting/exposition_formats/
