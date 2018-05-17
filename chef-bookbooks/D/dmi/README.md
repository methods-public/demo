dmi Cookbook
===================


[![Cookbook Version][cookbook_version]][cookbook]
[![Build Status][build_status]][build_status]

Configure and ensure the ohai dmi plugin works, especially on Windows

Requirements:
-------------
### Platforms
* Centos 6.x/7.x
* Rhel 6.x/7.x
* Windows 2008R2/2012/2012R2/2016

### Chef
* Chef version: >= 12.5.1
*

Attributes
----------
#### dmi on windows
* `node['dmi']['package']['name']` - used to get the windows package name
* `node['dmi']['package']['url']` - used to get the windows packages url
* `node['dmi']['package']['sha256sum']` - used to get the windows' package sha256sum
* `node['dmi']['path']` - used to set the path on windows


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
Copyright 2014-2015, Criteo.

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
[repository]:               https://github.com/criteo-cookbooks/dmi
[build_status]:             https://api.travis-ci.org/criteo-cookbooks/dmi.svg?branch=master
[cookbook_version]:         https://img.shields.io/cookbook/v/dmi.svg
[cookbook]:                 https://supermarket.chef.io/cookbooks/dmi
