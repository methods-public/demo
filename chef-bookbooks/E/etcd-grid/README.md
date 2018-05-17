etcd-grid Cookbook
==================

This cookbook sets up a etcd cluster.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [etcd-grid::default](#etcd-griddefault)
        - [etcd-grid::docker-compose (for TESTING)](#etcd-griddocker-compose-for-testing)
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
|`['etcd-grid']['image']['url']`|String|etcd container image URL.|`'quay.io/coreos/etcd'`|
|`['etcd-grid']['image']['version']`|String|Container image version.|`'v3.1'`|
|`['etcd-grid']['cluster']['size']`|Integer|recommended: 3, 5, 7|`3`|
|`['etcd-grid']['node']['port4client']`|String|Port number for client requests.|`'2379'`|
|`['etcd-grid']['node']['port4peer']`|String|Port number for peer communication.|`'2380'`|
|`['etcd-grid']['docker-compose']['app_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/etcd"`|
|`['etcd-grid']['docker-compose']['data_dir']`|String||`"#{node['etcd-grid']['docker-compose']['app_dir']}/data"`|
|`['etcd-grid']['docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### etcd-grid::default

This recipe does nothing.

#### etcd-grid::docker-compose (for TESTING)

This recipe generates a `docker-compose.yml` for the etcd cluster.

### Role Examples

- `roles/etcd-on-docker.rb`

```ruby
name 'etcd-on-docker'
description 'etcd on Docker'

run_list(
  'role[docker]',
  'recipe[etcd-grid::docker-compose]',
)

host_ip = '192.168.1.123'

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
  'etcd-grid' => {
    'image' => {
      'url' => 'quay.io/coreos/etcd',
      'version' => 'v3.1',
    },
    'cluster' => {
      'size' => 3,  # recommended: 3, 5, 7
    },
    'docker-compose' => {
      'config' => {
        'services' => {
          'etcd1' => {
            'ports' => [
              "#{host_ip}:23791:2379",
              "#{host_ip}:23801:2380",
            ],
          },
          'etcd2' => {
            'ports' => [
              "#{host_ip}:23792:2379",
              "#{host_ip}:23802:2380",
            ],
          },
          'etcd3' => {
            'ports' => [
              "#{host_ip}:23793:2379",
              "#{host_ip}:23803:2380",
            ],
          },
          # for TEST
          'client' => {
            'image' => 'quay.io/coreos/etcd:v3.1',
            'restart' => 'none',
            'entrypoint' => '/bin/sh -c "while true; echo dummy; do sleep 600; done"',
            'environment' => {
              'ETCDCTL_API' => '3',
              'ETCDCTL_ENDPOINTS' => 'http://etcd1:2379,http://etcd2:2379,http://etcd3:2379',
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
