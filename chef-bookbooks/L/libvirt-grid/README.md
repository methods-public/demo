libvirt-grid Cookbook
===================

This cookbook sets up a libvirtd service.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [libvirt-grid::default](#libvirt-griddefault)
        - [libvirt-grid::libvirtd](#libvirt-gridlibvirtd)
    - [Role Examples](#role-examples)
- [License and Authors](#license-and-authors)

## Requirements

### platforms

- Debian >= 9.0
- Ubuntu >= 16.04
- CentOS,RHEL >= 7.3

### packages
- none.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|

## Usage

### Recipes

#### libvirt-grid::default

This recipe does nothing.

#### libvirt-grid::libvirtd

This recipe sets up a libvirtd service.

### Role Examples

- `roles/libvirtd.rb`

```ruby
name 'libvirtd'
description 'libvirtd service'

run_list(
  'recipe[libvirt-grid::libvirtd]',
)

#env_run_lists

#default_attributes

override_attributes(
)
```

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2018, whitestar

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
