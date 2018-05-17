ratpoison Cookbook
===========================
Installs the Ratpoison window manager for X11.

The `default` recipe of this cookbook will install Xvfb
to provide a X11 implementation for Ratpoison to run on.
If you already have a X11 server running, use the
`windowmanager` recipe that only installs and runs
Ratpoison.

Build
-----

[![Build Status](https://travis-ci.org/miguelaferreira/ratpoison.svg?branch=setup-travis-ci)](https://travis-ci.org/miguelaferreira/ratpoison)

Requirements
------------
#### packages
- `yum-epel` - to provide the yum repositories
- `xvfb`     - to provide a X11 implementation

Attributes
----------

The ratpoison pacckage is not available in Epel repository for CentOS 7.
The cookbook provides the attribute `default['ratpoison']['rpm']['url']` and to specify the location where to download the ratpoison rpm from.
This attribute is needed for CentOS verions above 6.

Usage
-----
#### ratpoison::default
Include `ratpoison` in your node's `run_list` to have Xvfb and Ratpoison installed and running.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ratpoison]"
  ]
}
```

#### ratpoison::windowmanager
If you have a X11 implementation running on
your node, include `ratpoison::windowmanager` in your node's
`run_list` to have Ratpoison installed and running.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ratpoison::windowmanager]"
  ]
}
```

Contributing
------------

1. Fork the repository
2. Make your contribution
3. Make a pull request

License and Authors
-------------------
Authors: Miguel Ferreira

License
-------

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
