nginx-pkg Cookbook
====================
[![Build Status](https://travis-ci.org/st-isidore-de-seville/cookbook-nginx-pkg.svg?branch=master)](https://travis-ci.org/st-isidore-de-seville/cookbook-nginx-pkg)
[![Chef Cookbook](https://img.shields.io/cookbook/v/nginx-pkg.svg)](https://supermarket.chef.io/cookbooks/nginx-pkg)

Installs NGINX from a System Package.

This cookbook is concerned with installing NGINX from a system package sourced
from package repositories installed on the server.  

Requirements
------------
- Chef 11 or higher
- Ruby 1.9 or higher (preferably from the Chef full-stack installer)
- Network accessible package repositories

Attributes
----------
#### nginx-pkg::default

The default cookbook installs NGINX from a system package.

- `['nginx-pkg']['package']['name']`
  - _Type:_ String
  - _Description:_ The name of the NGINX system package to be installed.
  - _Default:_ `nginx`
- `['nginx-pkg']['package']['version']`
  - _Type:_ String/Array
  - _Description:_ The version of the NGINX system package to be installed.
    This defaults to the most current version of the package as determined by
    repository priority & settings.
  - _Default:_ `''`

Usage
-----
#### nginx-pkg::default
Just include `nginx-pkg` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nginx-pkg]"
  ]
}
```

If you are on a RHEL system, you may want to:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum-epel]",
    "recipe[nginx-pkg]"
  ]
}
```

If you want to install the NGINX vendor package, you may want to:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nginx-repo]",
    "recipe[nginx-pkg]"
  ]
}
```

Contributing
------------
1. Fork the repository on GitHub
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using GitHub

Development Environment
-------------------
This repository contains a Vagrantfile which can be used to spin up a
fully configured development environment in Vagrant.  

Vagrant requires the following:
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

The Vagrant environment for this repository is based on:
- [st-isidore-de-seville/trusty64-rvm-docker](https://atlas.hashicorp.com/st-isidore-de-seville/boxes/trusty64-rvm-docker)

The Vagrant environment will initialize itself to:
- install required Ruby gems
- run integration testing via kitchen-docker when calling `kitchen`

The Vagrant environment can be spun up by performing the following commands:

1. `vagrant up`
2. `vagrant ssh`
3. `cd /vagrant`

Authors
-------------------
- Author:: St. Isidore de Seville (st.isidore.de.seville@gmail.com)

License
-------------------
```text
The MIT License (MIT)

Copyright (c) 2015 St. Isidore de Seville (st.isidore.de.seville@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
