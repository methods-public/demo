Spark Platform
==============

Description
-----------

Apache Spark™ is a fast and general engine for large-scale data processing.

This cookbook is designed to install and configure Spark.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution:
- RHEL Family 7, tested on Centos

Usage
-----

### First Setup

The recommended way to use this cookbook is through the creation of a role
per **spark** cluster. This enables the search by role feature, allowing a
simple service discovery.

In fact, there are two ways to configure the search:
1. with a static configuration through a list of hostnames (attributes `hosts`
   that is `['spark-platform']['hosts']`)
2. with a real search, performed on a role (attributes `role` and `size`
   like in `['spark-platform']['role']`). The role should be in the run-list
   of all nodes of the cluster. The size is a safety and should be the number
   of nodes in the cluster.

If hosts is configured, `role` and `size` are ignored

See [roles](test/integration/roles) for some examples and
[Cluster Search][cluster-search] documentation for more information.

### Master High Availability

To install properly a HA **spark** cluster, set
`['spark-platform']['master_ha_with_zk']` to true. Then set the number of
masters you want with `['spark-platform']['n_of_masters']`.

You also need a **Zookeeper** cluster. This is not in the scope of this
cookbook but if you need one, you should consider using [Zookeeper
Platform][zookeeper-platform].

The configuration of Zookeeper hosts use search and is done similarly as for
**spark** hosts, _ie_ with a static list of hostnames or by using a search on
a role. The attribute to configure is `['spark-platform']['zookeeper']`.

### Java

By default, this cookbook installs *openjdk* from the official repositories
*(openjdk-headless 8 on centos 7)* just before starting the service. You can
change this behavior by setting `node['spark-platform']['java']` to `""`, or
choose your package by setting the package name in
`node['spark-platform']['java'][node[:platform]]`.

### Test

This cookbook is fully tested through the installation of the full platform
in docker hosts. This uses kitchen, docker and some monkey-patching.

If you run `kitchen list`, you will see 4 suites:

- zookeeper-centos-7
- spark-platform-1-centos-7
- spark-platform-2-centos-7
- spark-platform-3-centos-7

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

### Spark group

In standalone mode, it is not possible to execute spark jobs with different
users. This means that the result files will always be owned by spark user. To
be able to use different user accounts, a solution is to add all users to spark
group and make the files group modifiable. In this cookbook, the spark group is
created with "append true" option so other cookbooks can modify it to add
users.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Include other recipes, that is:

1. user
2. install
3. config
4. systemd
5. service

### user

Create user and group for Apache Spark.

### install

Install Apache Spark using a tarball package.

### config

Configure Apache Spark, searching for other cluster members if available.

### systemd

Create systemd unit files

### service

Enable and start services

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

- Author:: Samuel Bernard (<samuel.bernard@s4m.io>)
- Author:: Florian Philippon (<florian.philippon@s4m.io>)

```text
Copyright (c) 2016 Sam4Mobile

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
