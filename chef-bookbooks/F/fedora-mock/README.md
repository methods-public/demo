fedora-mock Cookbook
====================
[![Build Status](https://travis-ci.org/st-isidore-de-seville/cookbook-fedora-mock.svg?branch=master)](https://travis-ci.org/st-isidore-de-seville/cookbook-fedora-mock)
[![Chef Cookbook](https://img.shields.io/cookbook/v/fedora-mock.svg)](https://supermarket.chef.io/cookbooks/fedora-mock)

Installs [Fedora Mock](https://fedoraproject.org/wiki/Mock?rd=Subprojects/Mock)

Requirements
------------
- Chef 11 or higher
- Ruby 1.9 or higher (preferably from the Chef full-stack installer)
- Network accessible package repositories
- Fedora Mock is only accessible on Fedora & RHEL platform families
- yum-epel Cookbook (only executed on RHEL platforms families)

Attributes
----------
#### fedora-mock::default

- `['fedora-mock']['include-epel']`
  - _Type:_ Boolean
  - _Description:_ Does this cookbook automatically include the EPEL repository?
  - _Default:_ true if a RHEL platform family; false if Fedora
- `['fedora-mock']['plugins']`
  - _Type:_ Hash
  - _Description:_ Additional Fedora Mock plugins to install.  The hash key is
    the plugin.  If the hash value evaluates to true, the plugin will be
    installed.
  - _Default:_ `empty`
- `['fedora-mock']['users']`
  - _Type:_ Hash
  - _Description:_ Users of Fedora Mock.  The hash key is the user.  If the hash
    value evaluates to true, the user will be a managed group of Fedora Mock.
  - _Default:_ `empty`

Usage
-----
#### fedora-mock::default
Just include `fedora-mock` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fedora-mock]"
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
