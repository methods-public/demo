Aerospike Platform
=============

Description
-----------

Aerospike is a Flash, in-memory high perf NoSQL database & key-value store.

This cookbook is designed to install and configure an Aerospike cluster.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution:
- RHEL Family 7, tested on Centos

Usage
-----

### Test

This cookbook is fully tested through the installation of a working 3-nodes
cluster in docker hosts. This uses kitchen, docker and some monkey-patching.

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

### Easy Setup

Set `node['aerospike-platform']['hosts']` to an array containing the
hostnames of the nodes of the Aerospike cluster.

### Search

The recommended way to use this cookbook is through the creation of a role per
**Aerospike** cluster. This enables the search by role feature, allowing a
simple service discovery.

In fact, there are two ways to configure the search:

1. With a static configuration through a list of hostnames (attributes `hosts`
   that is `node['aerospike-platform']['hosts']`) for nodes belonging to
   Aerospike cluster).
2. With a real search, performed on a role (attributes `role` and `size`
   like in `node['aerospike-platform']['role']`).
   The role should be in the run-list of all nodes of the cluster.
   The size is a safety and should be the number of nodes of this role.

If hosts is configured, `role` and `size` are ignored

See [roles](test/integration/roles) for some examples and
[Cluster Search][cluster-search] documentation for more information.


Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in:

[attributes/default.rb](attributes/default.rb),
[attributes/config.rb](attributes/config.rb),
[attributes/systemd.rb](attributes/systemd.rb).

Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Include `search`, `user`, `install`, `config` and `systemd` recipes.

### search

Search Aerospike nodes that should join the cluster using
[Cluster Search][cluster-search].

### user

Create user/group used by Aerospike.

### install

Install and initialize Aerospike.

### config

Generate and deploy Aerospike config.

### systemd

Create systemd unit for Aerospike.

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

- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)
- Author:: Florian Philippon (<florian.philippon@@gmail.com>)

```text
Copyright (c) 2016 Sam4Mobile, 2018 Make.org

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

[cluster-search]: https://supermarket.chef.io/cookbooks/cluster-search
