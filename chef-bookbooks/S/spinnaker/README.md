spinnaker Cookbook
==================

This cookbook sets up a Spinnaker Halyard service.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [spinnaker::default](#spinnakerdefault)
        - [spinnaker::halyard-ddocker-compose](#spinnakerhalyard-ddocker-compose)
    - [Role Examples](#role-examples)
- [License and Authors](#license-and-authors)

## Requirements

### platforms

- Debian >= 9.0
- Ubuntu >= 14.04
- CentOS, RHEL >= 7.3

### packages
- none.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['spinnaker']['halyard-docker-compose']['app_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/halyard"`|
|`['spinnaker']['halyard-docker-compose']['config_dir']`|String||`"#{node['spinnaker']['halyard-docker-compose']['app_dir']}/.hal"`|
|`['spinnaker']['halyard-docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### spinnaker::default

This recipe does nothing.

#### spinnaker::halyard-ddocker-compose

This recipe generates a `docker-compose.yml` for the Spinnaker Halyard service.

### Role Examples

- `roles/halyard-on-docker.rb`

```ruby
name 'halyard-on-docker'
description 'Halyard on Docker'

run_list(
  'role[docker]',
  'recipe[spinnaker::halyard-docker-compose]',
)

#env_run_lists()

#default_attributes()

override_attributes(
  'docker-grid' => {
    'engine' => {
      'skip_setup' => false,
    },
    'compose' => {
      'skip_setup' => false,
    },
  },
  'spinnaker' => {
    'halyard-docker-compose' => {
      'config' => {
        'services' => {
          'halyard' => {
            'restart' => 'always',
            'image' => 'gcr.io/spinnaker-marketplace/halyard:stable',
            'ports' => [
              # default
              #'127.0.0.1:8064:8064',
            ],
            'volumes' => [
              # This volume will be set by the spinnaker::halyard-ddocker-compose recipe automatically.
              #"#{node['spinnaker']['halyard-docker-compose']['config_dir']}:/root/.hal:rw",
            ],
            'environment' => {
            },
          },
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
