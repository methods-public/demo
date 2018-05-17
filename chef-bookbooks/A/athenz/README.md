athenz Cookbook
===============

This cookbook sets up Athenz services.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [athenz::default](#athenzdefault)
        - [athenz::docker-compose](#athenzdocker-compose)
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
|`['athenz']['docker-compose']['app_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/athenz"`|
|`['athenz']['docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### athenz::default

This recipe does nothing.

#### athenz::docker-compose

This recipe generates a `docker-compose.yml` for the Athenz services.

### Role Examples

- `roles/athenz-on-docker.rb`

```ruby
name 'athenz-on-docker'
description 'Athenz on Docker'

#athenz_zms_port = '4443'  # default: 4443
#athenz_zts_port = '8443'  # default: 8443
#athenz_ui_port  = '9443'  # default: 9443

run_list(
  'role[docker]',
  'recipe[athenz::docker-compose]',
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
  'athenz' => {
    'docker-compose' => {
      'config' => {
        'services' => {
          'athenz' => {
            'image' => 'athenz/athenz:v1.7.12',  # NG: its image fails to start in the version 1.7.20 or later.
            #'ports' => [
            #  "#{athenz_zms_port}:4443",
            #  "#{athenz_zts_port}:8443",
            #  "#{athenz_ui_port}:9443",
            #],
            'environment' => {
            },
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
