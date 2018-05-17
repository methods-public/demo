kubernetes-grid Cookbook
========================

This cookbook sets up Kubernetes cluster.

## Contents

- [Requirements](#requirements)
  - [platforms](#platforms)
  - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
  - [Recipes](#recipes)
    - [kubernetes-grid::default](#kubernetes-griddefault)
    - [kubernetes-grid::master](#kubernetes-gridmaster)
    - [kubernetes-grid::node](#kubernetes-gridnode)
    - [kubernetes-grid::node-commons](#kubernetes-gridnode-commons)
  - [Role Examples](#role-examples)
- [License and Authors](#license-and-authors)

## Requirements

### platforms
- CentOS, Red Hat Enterprise Linux >= 7.2
- Ubuntu >= 16.04

### packages
- none.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['kubernetes-grid']['apt_repo']['url']`|String||`'http://apt.kubernetes.io/'`|
|`['kubernetes-grid']['apt_repo']['keyurl']`|String|You must set whether this `keyurl` or the following `keyserver` & `recv-keys`.|`'https://packages.cloud.google.com/apt/doc/apt-key.gpg'`|
|`['kubernetes-grid']['apt_repo']['keyserver']`|String||`nil`|
|`['kubernetes-grid']['apt_repo']['recv-keys']`|String||`nil`|
|`['kubernetes-grid']['apt_repo']['override_apt_line']`|String|e.g. `'deb http://apt.kubernetes.io/ kubernetes-xenial main'`|`''`|
|`['kubernetes-grid']['yum_repo']['baseurl']`|String||`'http://yum.kubernetes.io/repos/kubernetes-el7-x86_64'`|
|`['kubernetes-grid']['yum_repo']['gpgcheck']`|String||`'1'`|
|`['kubernetes-grid']['yum_repo']['repo_gpgcheck']`|String||`'1'`|
|`['kubernetes-grid']['yum_repo']['gpgkey']`|Array, String||See `attributes/default.rb`.|
|`['kubernetes-grid']['docker-engine']['setup']`|Boolean|Docker setup by the `docker-grid` cookbook.|`true`|

## Usage

### Recipes

#### kubernetes-grid::default

This recipe does nothing.

#### kubernetes-grid::gp-node

This recipe sets up a general-purpose (GP) node (master or worker).

#### kubernetes-grid::master

This recipe sets up a master node.

#### kubernetes-grid::node

This recipe sets up a worker node.

#### kubernetes-grid::node-commons

This recipe installs Kubernetes base packages.

### Role Examples

- `roles/kube0.rb`

```ruby
cluster_name = 'kube0'

name "#{cluster_name}"
description "#{cluster_name} cluster"

run_list(
)

override_attributes(
  'docker-grid' => {
    'engine' => {
      'version_on_centos' => '1.11.2-1',
      'version_on_ubuntu' => '1.11.2-0',
      'storage-driver_on_centos' => 'overlay',
      'storage-driver_on_ubuntu' => 'overlay',  # default: aufs
      #'userns-remap' => 'default',
      'daemon_extra_options' => '-H fd:// --bip=192.168.128.1/24 --fixed-cidr=192.168.128.0/24',
    },
  },
)
```

- `roles/kube0-master.rb`

```ruby
cluster_name = 'kube0'

name "#{cluster_name}-master"
description "#{cluster_name} cluster master node"

run_list(
  "role[#{cluster_name}]",
  'recipe[kubernetes-grid::master]',
)

override_attributes(
)
```

- `roles/kube0-node.rb`

```ruby
cluster_name = 'kube0'

name "#{cluster_name}-node"
description "#{cluster_name} cluster worker node"

run_list(
  "role[#{cluster_name}]",
  'recipe[kubernetes-grid::node]',
)

override_attributes(
)
```

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2016, whitestar

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
