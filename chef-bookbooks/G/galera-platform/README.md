Galera Platform
==============

Description
-----------

Galera Cluster is a true Multimaster Cluster based on synchronous
replication.

This cookbook is designed to install and configure a Galera
Cluster using MariaDB (by default) as DB backend.

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
per **galera** cluster. This enables the search by role feature, allowing a
simple service discovery.

In fact, there are two ways to configure the search:
1. with a static configuration through a list of hostnames (attributes `hosts`
   that is `['galera-platform']['hosts']`)
2. with a real search, performed on a role (attributes `role` and `size`
   like in `['galera-platform']['role']`). The role should be in the run-list
   of all nodes of the cluster. The size is a safety and should be the number
   of nodes in the cluster.

If hosts is configured, `role` and `size` are ignored

See [roles](test/integration/roles) for some examples and
[Cluster Search][cluster-search] documentation for more information.

### Test

This cookbook is fully tested through the installation of the full platform
in docker hosts. This uses kitchen, docker and some monkey-patching.

If you run `kitchen list`, you will see 4 suites:

- zookeeper-centos-7
- galera-platform-1-centos-7
- galera-platform-2-centos-7
- galera-platform-3-centos-7

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

Include other recipes, that is:

1. repository
2. package
3. config
4. percona (if sst method is set to xtrabackup)
5. service

### repository

Configure YUM repositories.

### package

Install galera and MariaDB.

### config

Configure galera and MariaDB, searching for other cluster members if available.

### percona

Install Percona xtrabackup if sst method is set to xtrabackup

### service

Enable and start services.

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
