Iptables Services
=================

Description
-----------

Install and configure *iptables-services*, an easy and clear way to manage
iptables firewall with save/restore feature.

Also ensure that configured rules are effectively the same that iptable
uses. Any rules added directly on a configured chain will be removed and
any removed rule will be readded. Save and restore rules on restart.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

- RHEL Family 7, tested on Centos

It should work with other systemd platform by configuring attributes like
package name.

Complete support and tests will come if requested.

Usage
-----

### Setup

Add `recipe[iptables-services]` in your run-list to install *iptables-services*
using the official distribution package.

By default rules are saved on stop and restored when ip(6)tables service
starts. No chain configuration is enforced by default.

IPV4 and IPV6 are both activated by default.

### Configure a chain

Configure `node['iptables-services'][ip(6)tables]['tables'][table][chain]`.
Read [attributes/default.rb](attributes/default.rb) for more details and look
at an example in
[test/integration/roles/iptables-services-kitchen.json](this role).

Once a chain has been configured, this cookbook will ensure that the rules are
always exactly as defined.

### Groups

Sometimes you want to apply a given rule to a set of IPs. For instance to
whitelist access to a database from a list of nodes. You can do that by
defining a group of machines in `node['iptables-services'][groups]`: either by
listing the IPs or by setting a node to search.

You'll find more details in [attributes/default.rb](attributes/default.rb) and
a example in tests ([.kitchen.yml](.kitchen.yml) and [test](test)).

### Test

This cookbook is fully tested by kitchen and a vagrant box.

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Include `install` and `config` recipes.

### install

Install **iptables-services** by using package. Save current rules at
installation.

### config

Configure ip(6)tables services from attributes.

### service

Enable and start ip(6)tables services.

### update

Apply chain configuration from attributes. If there is any modification from
current rules and attributes, the chain is flushed and reconfigured.

Look at [attributes/default.rb](attributes/default.rb) for more info on how
to configure a chain.

Changelog
---------

Available in [CHANGELOG.md](CHANGELOG.md).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Vincent Baret (<vbaret@gmail.com>)
- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2017-2018 Make.org

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
