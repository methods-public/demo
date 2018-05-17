DHCP Wrapper
============

Description
-----------

Install and configure [**ISC DHCP**](https://www.isc.org/downloads/dhcp/) by
wrapping cookbook [**dhcp**][dhcp].

Can also configure network interfaces by the use of cookbook
[**network_interfaces_v2**][ni], for instance to
set a static address at the server and dhcp for the clients.

Requirements
------------

### Cookbooks

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

- RHEL Family 7, tested on Centos

Note: it should work fine on Debian 8 but the official docker image does not
allow systemd to work easily, so it could not be tested.

Usage
-----

### Easy Setup

Add `recipe[dhcp-wrapper::server]` in your run-list to install and configure
**DHCPD**. Configuration will be fetched from attributes `node['dhcp']`. See
cookbook [**dhcp**][dhcp] documentation for more information.

Add `recipe[dhcp-wrapper::client]` to install a dhcp client.

Add `recipe[dhcp-wrapper::network_interface]` to configure your network
interfaces. Configuration is fetched from attributes
`node['dhcp-wrapper']['network-interface']` which should match those of
provider [**network_interface**][ni].

To see an example, look at [.kitchen.yml](.kitchen.yml).

### Test

This cookbook is fully tested through the installation of a server and a node
in docker hosts. This uses kitchen, docker and some monkey-patching.

If you run kitchen list, you will see 2 suites, Each corresponds to a different
server:

- server-centos-7: DHCPD server listening on eth1
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
`node['dhcp-wrapper']['servers']` defined as an array. Else, it is considered
as a client.

Recipes
-------

### default

Call **init** and then, following the node status, call **client** or
**server** recipe.

### init

Determine if the current machine is a server or a client. Write the result
in `run_state['dhcp-wrapper']['status']`. Then merge default and specific
(client or server) configurations and store the result in
`run_state['dhcp-wrapper']['config']`.

Note: **init** is included in all recipes.

### client

Install **dhclient** package.

### server

Proxy for **dhcp::server** recipe. Please look at [.kitchen.yml](.kitchen.yml)
and [**dhcp**][dhcp] documentation for more information.

### network\_interface

Call **network_interface_rhel** provider based on
attributes `node['dhcp-wrapper']['network-interface']`.
See [.kitchen.yml](.kitchen.yml) and cookbook
[**network_interface_v2**][ni] for more information.

Create static routes based on `node['dhcp-wrapper']['routes']` attribute.

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

- Author:: Samuel Bernard (<samuel.bernard@s4m.io>)

```text
Copyright (c) 2015-2016 Sam4Mobile

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

[dhcp]: https://supermarket.chef.io/cookbooks/dhcp
[ni]: https://supermarket.chef.io/cookbooks/network_interfaces_v2
