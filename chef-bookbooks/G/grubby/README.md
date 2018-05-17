Grubby Cookbook
=======================

[![Cookbook Version][cookbook_version]][cookbook]
[![Build Status][build_status]][build_status]

Install and configure `grubby`

Requirements:
-------------
### Platforms
* Centos 6.x/7.x
* Rhel 6.x/7.x

### Chef
* Chef version: >= 11

Attributes
----------
#### Grubby
* `node['grubby']['sysconfig']` - set the `grubby` configuration file
* `node['grubby']['config']` - hash to configure `grubby`

Usage
-----
Using this cookbook will install and configure `grubby`

For instance:
``` ruby
$ cat roles/modules.rb
name 'kernel-plus'
description 'Select kernel-plus as a default kernel'

run_list [
  'recipe[grubby]',
  'recipe[yum-epel]',
]

default_attributes(
grubby:
  config: {
    DEFAULTKERNEL: 'kernel-plus',
  },
)
```

Contributing
------------
1. Fork the [repository on Github][repository]
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


License and Authors
-------------------
Authors: [Jeremy Mauro][author] (<j.mauro@criteo.com>)

```text
Copyright 2014-2016, Criteo.

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

[author]:                   https://github.com/jmauro
[repository]:               https://github.com/criteo-cookbooks/grubby
[build_status]:             https://api.travis-ci.org/criteo-cookbooks/grubby.svg?branch=master
[cookbook_version]:         https://img.shields.io/cookbook/v/grubby.svg
[cookbook]:                 https://supermarket.chef.io/cookbooks/grubby
