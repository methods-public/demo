Storm Cluster
=================

Description
-----------

[Apache Storm](https://storm.apache.org/) is a free and open source distributed
realtime computation system. Storm makes it easy to reliably process unbounded
streams of data, doing for realtime processing what Hadoop did for batch
processing.

This cookbooks installs and configures Storm (> 1.0.0).

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution:
- RHEL Family 7, tested on Centos

Note: it should work quite fine on Debian 8 (with some attributes tuning) but
the official docker image does not allow Systemd to work easily, so it could
not be tested.

Usage
-----

### First Setup

The recommended way to use this cookbook is through the creation of a role
per **Storm** cluster. This enables the search by role feature, allowing a
simple service discovery.

In fact, there are two ways to configure the search:
1. with a static configuration through a list of hostnames (attributes `hosts`
   that is `['storm-platform']['hosts']`) (empty by default so deactivated)
2. with a real search, performed on a role (attributes `role` and `size` like
   in `['storm-platform']['role']`). The role should be in the run-list of all
   nodes of the cluster. The size is a safety and should be the number of nodes
   in the cluster.

If hosts is configured, `role` and `size` are ignored and search is
deactivated.

See [roles](test/integration/roles) for some examples and
[Cluster Search][cluster-search] documentation for more information.

By default, the first node in hosts array or in search result (sorted on fqdn)
will be setup with a Nimbus, a LogViewer and a UI. All other nodes will host a
Supervisor and a LogViewer. To get this cookbook to setup the nth node to be
the Nimbus instead of the first one, change attribute
`node['storm-platform']['nimbus_id']`. You can also activate Nimbus High
Availability. You will find more information in the following sections.

### Zookeeper Cluster

To install properly a **Storm** cluster, you need a **Zookeeper** cluster.
This is not in the scope of this cookbook but if you need one, you should
consider using [Zookeeper Platform][zookeeper-platform].

The configuration of Zookeeper hosts use search and is done similarly as for
**Storm** hosts, _ie_ with a static list of hostnames or by using a search on
a role. The attribute to configure are located in
`node['storm-platform']['zookeeper']`.

### Java

By default, this cookbook installs *openjdk* from the official repositories
*(openjdk-headless 8 on centos 7)* just before starting the service. You can
change this behavior by setting `node['storm-platform']['java']` to `""` (empty
string), or choose your package by setting the package name in
`node['storm-platform']['java'][node[:platform]]`.

### Nimbus High Availability

A new feature of Storm 1.0.0 is Nimbus High Availability. This allows a backup
nimbus to be elected as master nimbus when the later crashes. To do so, you
have to declare all possible nimbus. This can be done by setting
`node['storm-platform']['nimbus_id']` (default: 1) to the first nimbus and
`node['storm-platform']['n_of_nimbus']` (default: 1) to the number of nimbus.

### Test

This cookbook is fully tested through the installation of the full platform
in docker hosts. This uses kitchen, docker and some monkey-patching.

If you run `kitchen list`, you will see 4 suites:

- zookeeper-centos-7
- storm-01-centos-7
- storm-02-centos-7
- storm-03-centos-7

Each corresponds to a different node in the cluster. They are connected through
a bridge network named *kitchen*, which is created if necessary.

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

### Local cluster

The cluster installed with `kitchen converge` is fully working and can thus be
used as a local cluster for developments tests.

You can access it by using internal DNS of the docker network named *kitchen*
or by declaring each node in your hosts file. You can get each IP by
running:

    docker inspect --format \
      '{{.NetworkSettings.Networks.kitchen.IPAddress}}' container_name

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Install and fully configure a given **Storm** by including the recipes:
*install*, *create_user*, *config* and *systemd_service*, in that order.

### install

Install **Storm** from tar archive with **ark** cookbook.

### create\_user

Create a system user for **Storm**.

### config

Configure **Storm**.

### systemd\_service

Create Systemd service files and set them up. Different **Storm** services will
be set up following the kind of node (both may apply).

For a *nimbus*:
- nimbus
- logviewer
- ui

For a *supervisor*:
- supervisor
- logviewer

If multiple nimbus exist (to activate nimbus High Availability) then we
consider each nimbus to be both *nimbus* and *supervisor*. In this case, a
nimbus will run all the services.

Note: install *java* package (OpenJDK 8 on centos 7) by default, can be
disabled by setting `node['confluent-platform']['java']` to "" (empty string).
A platform specific configuration for the package to install is also possible.

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
- Contributor:: Guillaume Alaux (<guillaume.alaux@s4m.io>)

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

[cluster-search]: https://supermarket.chef.io/cookbooks/cluster-search
[zookeeper-platform]: https://supermarket.chef.io/cookbooks/zookeeper-platform
