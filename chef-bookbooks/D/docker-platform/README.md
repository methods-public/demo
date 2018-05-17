Docker Platform Cookbook
========================

Description
-----------

[Docker](https://www.docker.com) is an open-source project that automates
the deployment of applications inside software containers, by providing
an additional layer of abstraction and automation of operating-system-level
virtualisation on Linux.

Docker uses the resource isolation features of the Linux kernel such as cgroups
and kernel namespaces, and a union-capable file system such as aufs and others
to allow independent "containers" to run within a single Linux instance,
avoiding the overhead of starting and maintaining virtual machines.

This cookbook provides recipes to install and configure Docker with
configuration stored in attributes. It wraps [docker cookbook][] resources to
control Docker status and also provides resources to manager swarm cluster
creation and volumes deployment.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

- RHEL Family 7, tested on Centos

Note: by composing it with [apt-docker cookbook][], it should work fine on
Debian / Ubuntu.

Usage
-----

### Test

This cookbook is fully tested in test-kitchen, using docker itself and
serverspec verifier. Beware: tests are run in privileged mode.

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

In addition, you can use attributes to define [docker cookbook][] resources.
All you have to do is to define an attribute of the same name as the resource
you want to call containing the different instances of this resource. For
instance:

```json
"docker_volume": {
  "data": {
    "action": "create"
  },
  "to_remove": {
    "action": "remove"
  }
}
```

It creates a docker volume named `data` and remove the one called `to_remove`.
The key of each sub hash table is the name attribute and the value is an hash
table containing the resource configuration, mapping exactly the attribute name
defined in [docker cookbook][] documentation.

If you need multiple arguments for an attribute, you have to declare them in
an array. If you need an array as single argument, add an extra array.

For instance:

```json
"docker_container": {
  "my_alpine": {
    "container_name": "alpine",
    "repo": "alpine",
    "volumes": [["data:/data"]],
    "action": "run",
    "subscribes": ["redeploy", "docker_image[alpine]", "immediately"]
  }
}
```

You can find other examples in [.kitchen.yml](.kitchen.yml) file.

Recipes
-------

### default

Include all other recipes to install, configure, run and launch Docker
volumes/services.

### repository

Configure and install official docker yum repository.

### package

Install `docker-engine` package or upgrade it if attribute version is set to
`latest`.

### tls

Activate tls support if a data bag item is defined. Load cacert, cert, key
needed from it. See test data bag for more informations.

### config

Manage docker configuration file. Configuration keys can be manipulated by
attributes or by others recipes by setting the run\_state.

### service

Enable and start `docker` service.

### docker

Wrap all [docker cookbook][] resources so it is possible to use them with
attributes. Read [attributes](#attributes) section for more details.

### login

Create '/root/.docker/config.json' with authentication info declared in
`docker\_registry` attributes. In other work, make registries login permanent.

### swarm

Use `docker_platform_swarm` resource of the cookbook to initialize or join
a swarm. See [.kitchen.yml](.kitchen.yml) for examples.

Use [cluster-search cookbook][] to determine the list of managers and an
external consul cluster to orchestrate the initialization and the storage of
join tokens.

You need a **consul** cluster. This is not in the scope of this cookbook but
if you need one, you should consider using [Consul Platform][consul-platform].

### swarm\_services

Use `docker_platform_service` resource of the cookbook to manage swarm
services.

Resources/Providers
-------------------

### swarm

For instance:

Initialize a swarm and store token on consul:

```json
"docker_platform": {
  "swarm": {
    "consul": {
      "hosts": "consul-swarm-host"
    },
    "options": {
      "listen_addr": "0.0.0.0:2377",
      "action": "create"
    }
  }
}
```

Join an existing docker swarm with token stored on consul:

```json
"docker_platform": {
  "swarm": {
    "consul": {
      "hosts": "consul-swarm-host"
    },
    "action": ["join"]
  }
}
```

### service

Deploy 5 replicas of redis image on a docker swarm with a placement preference:

```json
"docker_platform": {
  "services": {
    "redis": {
      "action": "create",
      "replicas": 5,
      "image": "redis:latest",
      "options": {
        "placement-pref": [
          "spread=node.labels.datacenter", "spread=node.labels.rack"
        ]
      }
    }
  }
}
```

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
- Author:: Florian Philippon (<florian.philippon@gmail.com>)

```text
Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org

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

[docker]: https://docker.io
[apt-docker cookbook]: https://supermarket.chef.io/cookbooks/apt-docker
[docker cookbook]: https://supermarket.chef.io/cookbooks/docker
[cluster-search cookbook]: https://supermarket.chef.io/cookbooks/cluster-search
[consul-platform]: https://supermarket.chef.io/cookbooks/consul-platform
