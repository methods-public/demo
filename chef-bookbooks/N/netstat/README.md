Netstat Cookbook
================
[![GitHub](http://img.shields.io/badge/github-zuazo/netstat--cookbook-blue.svg?style=flat)](https://github.com/zuazo/netstat-cookbook)
[![License](https://img.shields.io/github/license/zuazo/netstat-cookbook.svg?style=flat)](#license-and-author)

[![Cookbook Version](https://img.shields.io/cookbook/v/netstat.svg?style=flat)](https://supermarket.chef.io/cookbooks/netstat)
[![Dependency Status](http://img.shields.io/gemnasium/zuazo/netstat-cookbook.svg?style=flat)](https://gemnasium.com/zuazo/netstat-cookbook)
[![Build Status](http://img.shields.io/travis/zuazo/netstat-cookbook/0.2.0.svg?style=flat)](https://travis-ci.org/zuazo/netstat-cookbook)

[Chef](https://www.chef.io/) cookbook to install `netstat` network tool. Recommended for [Docker](https://www.docker.com/) containers.

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon Linux
* CentOS
* Debian
* Fedora
* openSUSE
* Oracle Linux
* RedHat
* Scientific Linux
* SUSE
* Ubuntu

Please, [let me know](https://github.com/zuazo/netstat-cookbook/issues/new?title=I%20have%20used%20it%20successfully%20on%20...) if you use it successfully on any other platform.

## Required Applications

* Chef `12` or higher.
* Ruby `2.2` or higher.

Platform Support Related Attributes
===================================

Some cookbook attributes are used internally to support the different platforms. Surely you want to change them if you want to support new platforms or want to improve the support of some platforms already supported.

| Attribute                     | Default       | Description                      |
|-------------------------------|:-------------:|----------------------------------|
| `node['netstat']['packages']` | *calculated*  | Package list to install netstat. |

Recipes
=======

## netstat::default

Installs netstat.

Usage Examples
==============

## Including in a Cookbook Recipe

You can simply include it in a recipe:

```ruby
include_recipe 'netstat'
```

Don't forget to include the `netstat` cookbook as a dependency in the metadata.

```ruby
# metadata.rb
# [...]

depends 'netstat'
```

## Including in the Run List

Another alternative is to include the default recipe in your *Run List*:

```json
{
  "name": "www.example.com",
  "[...]": "[...]",
  "run_list": [
    "recipe[netstat]"
  ]
}
```

Deploy with Docker
==================

You can use the *Dockerfile* included in the [cookbook source code](https://github.com/zuazo/netstat-cookbook) to run the cookbook inside a container:

    $ docker build -t chef-netstat .
    $ docker run -ti chef-netstat netstat -nptua

The sample *Dockerfile*:

```Dockerfile
FROM zuazo/chef-local:debian-7

COPY . /tmp/netstat
RUN berks vendor -b /tmp/netstat/Berksfile $COOKBOOK_PATH
RUN chef-client -r "recipe[apt],recipe[netstat]"

CMD ["netstat", "-nptua"]
```

See the [chef-local container documentation](https://registry.hub.docker.com/u/zuazo/chef-local/) for more examples.

Testing
=======

See [TESTING.md](https://github.com/zuazo/netstat-cookbook/blob/master/TESTING.md).

Contributing
============

Please do not hesitate to [open an issue](https://github.com/zuazo/netstat-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/zuazo/netstat-cookbook/blob/master/CONTRIBUTING.md).

TODO
====

See [TODO.md](https://github.com/zuazo/netstat-cookbook/blob/master/TODO.md).


License and Author
=====================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Xabier de Zuazo](https://github.com/zuazo) (<xabier@zuazo.org>)
| **Copyright:**       | Copyright (c) 2015, Xabier de Zuazo
| **License:**         | Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
