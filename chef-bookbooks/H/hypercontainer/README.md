hypercontainer Cookbook
=======================

This cookbook sets up a HyperContainer.

## Contents

- [Requirements](#requirements)
	- [platforms](#platforms)
	- [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
	- [Recipes](#recipes)
		- [hypercontainer::default](#hypercontainerdefault)
	- [Role Examples](#role-examples)
- [License and Authors](#license-and-authors)

## Requirements

### platforms

- Debian >= 9.0
- Ubuntu >= 14.04
- CentOS,RHEL >= 7.3

### packages
- none.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['hypercontainer']['install_flavor']`|String|`'script'` or `'direct_download'`|`'script'`|
|`['hypercontainer']['fallback_direct_download_install']`|Boolean|fallback from install via script to direct download install.|`true`|
|`['hypercontainer']['package']['version']`|String||`'1.0.0-1'`|
|`['hypercontainer']['package']['download_url_context']`|String|URL context path for package download.|`"https://hypercontainer-download.s3-us-west-1.amazonaws.com/#{ver_ctx}/#{platform}"`|
|`['hypercontainer']['package']['hypercontainer']`|String|hypercontainer package file name.|See `attributes/default.rb`|
|`['hypercontainer']['package']['hyperstart']`|String|hyperstart package file name.|See `attributes/default.rb`|
|`['hypercontainer']['auto_upgrade']`|Boolean|enable auto upgrade by Chef.|`false`|
|`['hypercontainer']['hypervisor']`|String|`'qemu'` or `'xen'` for Debian family.|`'qemu'`|
|`['hypercontainer']['daemon_extra_options']`|String||`'--log_dir=/var/log/hyper'`|
|`['hypercontainer']['config']`|Hash|This hash is expanded to the `/etc/hyper/config` file.|See `attributes/default.rb`|

## Usage

### Recipes

#### hypercontainer::default

This recipe installs HyperContainer.

### Role Examples

- `roles/hypercontainer.rb`

```ruby
name 'hypercontainer'
description 'HyperContainer'

run_list(
  'recipe[hypercontainer::default]',
)

#env_run_lists()

#default_attributes()

override_attributes(
  'hypercontainer' => {
    'auto_upgrade' => false,
    'hypervisor' => 'qemu',  # 'qemu' or 'xen' for Debian family.
    'config' => {
      'global' => {
        'StorageDriver' => 'overlay',
      },
    },
  },
)
```

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2017, whitestar

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
