zookeeper Cookbook
==================

This cookbook sets up Zookeeper ensemble (cluster).

## Contents

- [Requirements](#requirements)
    - [cookbooks](#cookbooks)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [zookeeper::default](#zookeeperdefault)
    - [Role examples](#role-examples)
- [License and Authors](#license-and-authors)

## Requirements

### cookbooks
- grid
- java

### packages
none.

## Attributes

|Key|Type|Description (with examples)|Default|
|:--|:--|:--|:--|
|`['zookeeper']['install_flavor']`|String|distribution.|`'apache'`|
|`['zookeeper']['version']`|String|Zookeeper's version.|`'3.4.5'`|
|`['zookeeper']['archive_url']`|String|archive URL.|`'http://archive.apache.org/dist/zookeeper'`|
|`['zookeeper']['colo_name']`|String|colocation name|`'localhost'`|
|`['zookeeper']['member_of_hadoop']`|Boolean|whether a member of hadoop or not.|`false`|
|`['zookeeper']['run_mode']`|String|`'standalone'`, `'pseudo-replicated'`, `'full-replicated'`|`'standalone'`|
|`['zookeeper']['with_security']`|Boolean|work with security.|`false`|
|`['zookeeper']['realm']`|String|Kerberos realm.|`'LOCALDOMAIN'`|
|`['zookeeper']['keytab_dir']`|String|keytab stored directory.|`"#{node['grid']['etc_root']}/keytabs/#{node['zookeeper']['colo_name']}"`|
|`['zookeeper']['ZOOKEEPER_PREFIX']`|String|property in the zookeeper-env.sh file.|`"#{node['grid']['app_root']}/zookeeper"`|
|`['zookeeper']['ZOO_LOG_DIR_PREFIX']`|String||`"#{node['grid']['vol_root']}/0/var/log/zookeeper"`|
|`['zookeeper']['dataDirPrefix']`|String|property in the zoo.cfg file.|`"#{node['grid']['vol_root']}/0/var/lib/zookeeper"`|
|`['zookeeper']['dataLogDir']`|String||`nil`|
|`['zookeeper']['clientPort']`|String||`'2181'`|
|`['zookeeper']['ensemble']`|Hash|see attributes/default.rb|`{}` (empty)|
|`['zookeeper']['tickTime']`|String||`'2000'`|
|`['zookeeper']['initLimit']`|String||`'10'`|
|`['zookeeper']['syncLimit']`|String||`'5'`|
|`['zookeeper']['authProvider']['0']`|String|if it works with_security, the following properties are activated.|`'org.apache.zookeeper.server.auth.SASLAuthenticationProvider'`|
|`['zookeeper']['jaasLoginRenew']`|String||`'3600000'`|
|`['zookeeper']['kerberos.removeHostFromPrincipal']`|String||`'true'`|
|`['zookeeper']['kerberos.removeRealmFromPrincipal']`|String||`'true'`|
|`['zookeeper']['extra_configs']['zookeeper-env.sh']`|Hash|extra properties. key and value pairs|`{}` (empty)|
|`['zookeeper']['extra_configs']['zoo.cfg']`|Hash|extra properties. key and value pairs|`{}` (empty)|
|`['zookeeper']['extra_configs']['java.env']`|Hash|extra properties. key and value pairs|`{}` (empty)|

## Usage

### Recipes

#### zookeeper::default
- installs Zookeeper and sets up ensemble's nodes.

### Role examples

- `roles/zookeeper.rb`

```ruby
name 'zookeeper'
description 'ZooKeeper node'

run_list(
  'recipe[grid]',
  'recipe[java]',
  'recipe[zookeeper]'
)

default_attributes(
  'java' => {
    'install_flavor' => 'oracle',
    'jdk_version' => '7',
    'java_home' => '/usr/local/jvm/java-7-ora',
    'oracle' => {
      'accept_oracle_download_terms' => true,
    },
  }
)

override_attributes(
  'java' => {
    'jdk' => {
      '7' => {
        # no update-alternatives
        'bin_cmds' => [],
      },
    },
  }
)
```

- `roles/zookeeper-standalone.rb`

```ruby
name 'zookeeper-standalone'
description 'ZooKeeper standalone mode'

run_list(
  'role[zookeeper]'
)

default_attributes(
  'zookeeper' => {
    'run_mode' => 'standalone',
    'member_of_hadoop' => true,
  }
)
```

- `roles/zookeeper-pseudo-replicated.rb`

```ruby
name 'zookeeper-pseudo-replicated'
description 'ZooKeeper pseudo replicated mode'

run_list(
  'role[zookeeper]'
)

default_attributes(
  'zookeeper' => {
    'run_mode' => 'pseudo-replicated',
    'member_of_hadoop' => true,
    'clientPort' => '2180',
  }
)
```

- `roles/zookeeper-colo00.rb`

```ruby
name 'zookeeper-colo00'
description 'ZooKeeper colo00 node'

run_list(
  'role[zookeeper]'
)

ensemble = {
  '0' => {
    :hostname => 'zk00.grid.example.com',
    :leader_port => '2888',
    :election_port => '3888',
  },
  '1' => {
    :hostname => 'zk01.grid.example.com',
    :leader_port => '2888',
    :election_port => '3888',
  },
  '2' => {
    :hostname => 'zk02.grid.example.com',
    :leader_port => '2888',
    :election_port => '3888',
  }
}

default_attributes(
  'zookeeper' => {
    'run_mode' => 'full-replicated',
    'colo_name' => 'colo00',
    'dataLogDir' => '/grid/vol/1/var/lib/zookeeper',
    'ensemble' => ensemble,
  }
)
```

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2013-2017, whitestar

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
