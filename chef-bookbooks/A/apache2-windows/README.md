# Chef Cookbook for Apache 2 on Windows

[![Build Status](https://travis-ci.org/chef-cookbooks/apache2-windows.svg?branch=master)](http://travis-ci.org/chef-cookbooks/apache2-windows) [![Cookbook Version](https://img.shields.io/cookbook/v/apache2-windows.svg)](https://supermarket.chef.io/cookbooks/apache2-windows)

Installs and configures Apache 2 on Windows.

## Requirements

### Platforms
- Windows Server 2008 R2 and later

### Chef

- Chef 12.6+

### Cookbooks

- none

## Usage

### apache2-windows::default

Just include `apache2-windows` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[apache2-windows]"
  ]
}
```

## License and Authors

- Author:: Yvo Van Doorn (yvo@chef.io)
- Author:: Chris McClimans (hh@hippiehacker.org)
- Author:: Dan Robinson (dan@chef.io)
- Author:: Julian Dunn (jdunn@chef.io)
- Author:: James Francis (james@gnslngr.us)

- Copyright (C) 2013-2014 Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
