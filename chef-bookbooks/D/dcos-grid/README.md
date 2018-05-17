dcos-grid Cookbook
==================

This cookbook sets up your customized DC/OS cluster on bare metal, virtual machines and every cloud. This install method is based on [_Advanced DC/OS Installation Guide_](https://dcos.io/docs/1.8/administration/installing/custom/advanced/).

## Contents

- [Requirements](#requirements)
  - [platforms](#platforms)
  - [packages](#packages)
  - [cookbooks](#cookbooks)
- [Attributes](#attributes)
- [Usage](#usage)
  - [Recipes](#recipes)
    - [dcos-grid::default](#dcos-griddefault)
    - [dcos-grid::agent](#dcos-gridagent)
    - [dcos-grid::bootstrap](#dcos-gridbootstrap)
    - [dcos-grid::cli (ver. 0.3.0 or later)](#dcos-gridcli-ver-030-or-later)
    - [dcos-grid::cloud-config (for CoreOS only)](#dcos-gridcloud-config-for-coreos-only)
    - [dcos-grid::master](#dcos-gridmaster)
    - [dcos-grid::node](#dcos-gridnode)
    - [dcos-grid::node-commons](#dcos-gridnode-commons)
    - [dcos-grid::public-agent](#dcos-gridpublic-agent)
    - [dcos-grid::universe-build-env (ver. 0.4.8 or later)](#dcos-griduniverse-build-env-ver-048-or-later)
    - [dcos-grid::universe-server (ver. 0.4.9 or later)](#dcos-griduniverse-server-ver-049-or-later)
  - [Role Examples](#role-examples)
  - [Upgrade DC/OS (ver. 0.4.3 or later)](#upgrade-dcos-ver-043-or-later)
  - [Uninstall DC/OS](#uninstall-dcos)
- [License and Authors](#license-and-authors)

## Requirements

### platforms
- CentOS, Red Hat Enterprise Linux >= 7.2
- CoreOS Latest version.
- Ubuntu 16.04 (Experimental). DC/OS does not officially support Ubuntu yet. See [_Ubuntu 16.04 Enablement_](https://dcosjira.atlassian.net/browse/DCOS-25).
  - DC/OS requires systemd, which is only fully supported in Ubuntu 15.04 and later releases. See [_SystemdForUpstartUsers_](https://wiki.ubuntu.com/SystemdForUpstartUsers)

### packages
- none.

### cookbooks
- `docker-grid` (for `dcos-grid` ver. 0.4.0 or later).

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['dcos-grid']['dcos_release_url']`|String|DC/OS download URL.|`'https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh'`|
|`['dcos-grid']['dcos_release_checksum']`|String|sha256 checksum of the DC/OS release. (ver. 0.5.0 or later)|`nil` (no check)|
|`['dcos-grid']['dcos_release_script_name']`|String|OSS edition: `'dcos_generate_config.sh'`, Enterprise edition: `'dcos_generate_config.ee.sh'`  (ver. 0.4.8 or later).|`Pathname(URI(node['dcos-grid']['dcos_release_url']).path).basename`|
|`['dcos-grid']['dcos_cli_release_url']`|String|DEPRECATED: DC/OS CLI download URL (ver. 0.3.0 or later).|`"https://downloads.dcos.io/binaries/cli/linux/x86-64/#{node['dcos-grid']['cli']['version']}/dcos"`|
|`['dcos-grid']['dcos_cli_upgrade']`|Boolean|DEPRECATED: Whether upgrade DC/OS CLI or not (ver. 0.4.3 or later).|`false`|
|`['dcos-grid']['cli']['version']`|String|DC/OS CLI version (ver. 0.5.0 or later)|`'0.4.14'`|
|`['dcos-grid']['cli']['release_url']`|String| (ver. 0.5.0 or later)|`node['dcos-grid']['dcos_cli_release_url']`|
|`['dcos-grid']['cli']['release_checksum']`|String|sha256 checksum of the DC/OS CLI release. (ver. 0.5.0 or later)|`nil` (no check)|
|`['dcos-grid']['cli']['auto_upgrade']`|Boolean| (ver. 0.5.0 or later)|`node['dcos-grid']['dcos_cli_upgrade']`|
|`['dcos-grid']['cli']['install_path']`|String| (ver. 0.5.0 or later)|`'/usr/local/bin/dcos'`|
|`['dcos-grid']['docker']['apt_repo']['url']`|String|DEPRECATED: use `['docker-grid']['apt_repo']['url']` (ver. 0.4.0 or later)|`nil`|
|`['dcos-grid']['docker']['apt_repo']['keyserver']`|String|DEPRECATED: use `['docker-grid']['apt_repo']['keyserver']` (ver. 0.4.0 or later)|`nil`|
|`['dcos-grid']['docker']['apt_repo']['recv-keys']`|String|DEPRECATED: use `['docker-grid']['apt_repo']['recv-keys']` (ver. 0.4.0 or later)|`nil`|
|`['dcos-grid']['docker']['yum_repo']['baseurl']`|String|DEPRECATED: use `['docker-grid']['yum_repo']['baseurl']` (ver. 0.4.0 or later)|`nil`|
|`['dcos-grid']['docker']['yum_repo']['gpgcheck']`|String|DEPRECATED: use `['docker-grid']['yum_repo']['gpgcheck']` (ver. 0.4.0 or later). `'0'`: disabled, `'1'`: enabled.|`nil`|
|`['dcos-grid']['docker']['yum_repo']['gpgkey']`|String|DEPRECATED: use `['docker-grid']['yum_repo']['gpgkey']` (ver. 0.4.0 or later)|`nil`|
|`['dcos-grid']['docker-engine']['setup']`|Boolean|Docker setup by this cookbook. If you will set up Docker by another cookbook, verify that this attribute is false. (ver. 0.3.0 or later)|`true`|
|`['dcos-grid']['docker-engine']['version_on_centos']`|String|DEPRECATED: use `['docker-grid']['engine']['version_on_centos']` (ver. 0.4.0 or later). Docker version for CentOS.|`nil`|
|`['dcos-grid']['docker-engine']['version_on_ubuntu']`|String|DEPRECATED: use `['docker-grid']['engine']['version_on_ubuntu']` (ver. 0.4.0 or later). Docker version for Ubuntu.|`nil`|
|`['dcos-grid']['docker-engine']['version']`|String|DEPRECATED: use `['docker-grid']['engine']['version']` (ver. 0.4.0 or later). Docker 1.9.x - 1.11.x is recommended for stability reasons. Note: this **default** value is overwritten by the `version_on_{centos or ubuntu}`.|See default.rb|
|`['dcos-grid']['docker-engine']['storage-driver_on_centos']`|String|DEPRECATED: use `['docker-grid']['engine']['storage-driver_on_centos']` (ver. 0.4.0 or later). Docker storage driver (overlay, devicemapper, ...) for CentOS.|`nil`|
|`['dcos-grid']['docker-engine']['storage-driver_on_ubuntu']`|String|DEPRECATED: use `['docker-grid']['engine']['storage-driver_on_ubuntu']` (ver. 0.4.0 or later). Docker storage driver (aufs, overlay, ...) for Ubuntu.|`nil`|
|`['dcos-grid']['docker-engine']['storage-driver']`|String|DEPRECATED: use `['docker-grid']['engine']['storage-driver']` (ver. 0.4.0 or later).|See default.rb|
|`['dcos-grid']['docker-engine']['daemon_extra_options']`|String|DEPRECATED: use `['docker-grid']['engine']['daemon_extra_options']` (ver. 0.4.0 or later). ref. `docker daemon --help`.|`nil`|
|`['dcos-grid']['bootstrap']['ip']`|String|Bootstrap node IP address.|`'127.0.0.1'`|
|`['dcos-grid']['bootstrap']['port']`|String|Bootstrap node port number.|`'8080'`|
|`['dcos-grid']['bootstrap']['genconf_dir']`|String|genconf directory path. Note: This is overridden by the value `"#{node['dcos-grid']['cloud-config']['target_dir']}/genconf"` in the `cloud-config` recipe (ver. 0.3.5 or later).|`'/opt/dcos-grid/genconf'`|
|`['dcos-grid']['bootstrap']['config']`|Hash|Install configurations.|see [_Install Configuration Parameters_](https://dcos.io/docs/1.8/administration/installing/custom/configuration-parameters/)|
|`['dcos-grid']['bootstrap']['config']['bootstrap_url']`|String||`"http://#{node['dcos-grid']['bootstrap']['ip']}:#{node['dcos-grid']['bootstrap']['port']}"`|
|`['dcos-grid']['bootstrap']['config']['cluster_name']`|String||`'dcos0'`|
|`['dcos-grid']['bootstrap']['config']['exhibitor_storage_backend']`|String||`'static'`|
|`['dcos-grid']['bootstrap']['config']['ip_detect_filename']`|String||`'/genconf/ip-detect'`|
|`['dcos-grid']['bootstrap']['config']['master_discovery']`|String|(ver. 0.3.2 or later)|`'static'`|
|`['dcos-grid']['bootstrap']['config']['master_list']`|Array|e.g. `['192.168.1.101','192.168.1.102','192.168.1.103']`|`nil`|
|`['dcos-grid']['bootstrap']['config']['oauth_auth_host']`|String|(ver. 0.3.2 or later)|`'https://dcos.auth0.com'`|
|`['dcos-grid']['bootstrap']['config']['oauth_auth_redirector']`|String|(ver. 0.3.2 or later)|`'https://auth.dcos.io'`|
|`['dcos-grid']['bootstrap']['config']['oauth_available']`|String|(ver. 0.3.2 or later)|`'true'`|
|`['dcos-grid']['bootstrap']['config']['oauth_enabled']`|String|(ver. 0.3.2 or later)|`'true'`|
|`['dcos-grid']['bootstrap']['config']['oauth_issuer_url']`|String|(ver. 0.3.2 or later)|`'https://dcos.auth0.com/'`|
|`['dcos-grid']['bootstrap']['config']['resolvers']`|Array|e.g. `['8.8.8.8','8.8.4.4']` (Google DNS)|`nil`|
|`['dcos-grid']['bootstrap']['config']['telemetry_enabled']`|String||`'false'` (ver. 0.4.1 or later)|
|`['dcos-grid']['bootstrap']['bootstrap']['ip-detect']['interface']`|String|Network interface on each node for the `ip-detect` script. Note: If you set comma-delimited interface list (e.g. `'eth0,enp0s3'`), the first detected interface's ip is adopted (ver. 0.3.0 or later). |`'eth0'`|
|`['dcos-grid']['node']['auto_setup']`|Boolean|execute the node setup script automatically or not.|`false`|
|`['dcos-grid']['cloud-config']['target_platform']`|String|CoreOS only now.|`'coreos'`|
|`['dcos-grid']['cloud-config']['target_dir']`|String||`'/home/core'`|
|`['dcos-grid']['cloud-config']['target_owner']`|String||`'core:core'`|
|`['dcos-grid']['cloud-config']['hostname']`|String||`'<fqdn>'`|
|`['dcos-grid']['cloud-config']['timezone']`|String||`'Etc/GMT'`|
|`['dcos-grid']['cloud-config']['ssh_authorized_keys']`|Array||`['<your_ssh_pub_key>',]`|
|`['dcos-grid']['universe-server']['docker-compose']['app_dir']`|String||`'/opt/docker-compose/app/dcos-universe'`|
|`['dcos-grid']['universe-server']['docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### dcos-grid::default

This recipe does nothing.

#### dcos-grid::agent

This recipe sets up a private agent node. Note: If `node['dcos-grid']['node']['auto_setup']` is `false`, you must execute the following manually.

```
$ /opt/dcos-grid/node_setup.sh slave
```

#### dcos-grid::bootstrap

This recipe sets up a bootstrap node. Note: Please execute the following manually.

```
$ /opt/dcos-grid/bootstrap_setup.sh
```

#### dcos-grid::cli (ver. 0.3.0 or later)

This recipe installs DC/OS CLI.

#### dcos-grid::cloud-config (for CoreOS only)

This recipe generates a `/home/core/cloud-config.yaml` template file on local machine by the following `chef-solo` command.

```
$ sudo chef-solo -c solo.rb -j nodes/local-dcos0-cloud-config.json
```

- `nodes/local-dcos0-cloud-config.json`

```json
{
  "run_list": [
    "role[dcos0-cloud-config]"
  ]
}
```

- `roles/dcos0-cloud-config.rb`

```ruby
cluster_name = 'dcos0'

name "#{cluster_name}-cloud-config"
description "#{cluster_name} cloud-config.yaml file."

run_list(
  "role[#{cluster_name}]",  # includes common attributes.
  'recipe[dcos-grid::cloud-config]',
)
```

Then edit this yaml template (hostname, ssh_authorized_keys, IP address and so on) and install CoreOS by the `cloud-config.yaml`.

```
$ coreos-cloudinit -from-file ~/cloud-config.yaml -validate
...
$ sudo coreos-install -d /dev/sda -C stable -c ~/cloud-config.yaml
```

#### dcos-grid::gp-node

This recipe sets up a general-purpose (GP) node (particular role is not assigned yet). Note: Please execute which of the following commands as needed.

```
$ /opt/dcos-grid/bootstrap_setup.sh
 or
$ /opt/dcos-grid/node_setup.sh master
 or
$ /opt/dcos-grid/node_setup.sh agent
 or
$ /opt/dcos-grid/node_setup.sh agent_public
```

#### dcos-grid::master

This recipe sets up a master node. Note: If `node['dcos-grid']['node']['auto_setup']` is `false`, you must execute the following manually.

```
$ /opt/dcos-grid/node_setup.sh master
```

#### dcos-grid::node

This recipe sets up a base node (particular role is not assigned yet). Note: Please execute the following manually.

```
$ /opt/dcos-grid/node_setup.sh {master|slave|slave_public}
```

#### dcos-grid::node-commons

This recipe sets up common environment for DC/OS node.

#### dcos-grid::public-agent

This recipe sets up a public node. Note: If `node['dcos-grid']['node']['auto_setup']` is `false`, you must execute the following manually.

```
$ /opt/dcos-grid/node_setup.sh slave_public
```

#### dcos-grid::universe-build-env (ver. 0.4.8 or later)

This recipe sets up the build environment for DC/OS Universe (package repository) server.

#### dcos-grid::universe-server (ver. 0.4.9 or later)

This recipe sets up a DC/OS Universe (package repository) server.

### Role Examples

- `roles/dcos0.rb`: Common attributes.

```ruby
cluster_name = 'dcos0'

name cluster_name
description "#{cluster_name} cluster"

run_list(
)

override_attributes(
  'docker-grid' => {
    'engine' => {
      'version_on_centos' => '1.11.2-1',
      'version_on_ubuntu' => '1.11.2-0',
      #'version' => '1.11.2-1.el7.centos',
    },
  },
  'dcos-grid' => {
    'dcos_release_url' => 'https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh',
    #'dcos_release_url' => 'https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh',
    # DC/OS 1.8.7
    'dcos_release_checksum' => 'ddd9a86e4fc6ab149fb6c2ce38fc7d7c2f5891e62fb5ed41b91c3e99e02ed536',
    'bootstrap' => {
      'ip' => '192.168.56.100',
      'port' => '8080',
      'config' => {
        'cluster_name' => cluster_name,
        'master_list' => [
          '192.168.56.101',
          '192.168.56.102',
          '192.168.56.103',
        ],
        'resolvers' => [
          '8.8.8.8',
          '8.8.4.4',
        ],
      },
      'ip-detect' => {
        'interface' => 'eth1,enp0s8',
      },
    },
    'node' => {
      'auto_setup' => false,
    },
  },
)
```

- `roles/dcos0-boot.rb`

```ruby
cluster_name = 'dcos0'

name "#{cluster_name}-boot"
description "#{cluster_name} cluster bootstrap node"

run_list(
  "role[#{cluster_name}]",
  'recipe[dcos-grid::bootstrap]',
)
```

- `roles/dcos0-master.rb`

```ruby
cluster_name = 'dcos0'

name "#{cluster_name}-master"
description "#{cluster_name} cluster master node"

run_list(
  "role[#{cluster_name}]",
  'recipe[dcos-grid::master]',
)

override_attributes(
  'dcos-grid' => {
    'node' => {
      'auto_setup' => false,
    },
  },
)
```

- `roles/dcos0-agent.rb`

```ruby
cluster_name = 'dcos0'

name "#{cluster_name}-agent"
description "#{cluster_name} cluster private agent node"

run_list(
  "role[#{cluster_name}]",
  'recipe[dcos-grid::agent]',
)

override_attributes(
  'dcos-grid' => {
    'node' => {
      'auto_setup' => true,
    },
  },
)
```

- `roles/dcos0-cli.rb`

```ruby
cluster_name = 'dcos0'

name "#{cluster_name}-cli"
description "#{cluster_name} CLI setup"

run_list(
  "role[#{cluster_name}]",
  'recipe[dcos-grid::cli]',
)

override_attributes(
  'dcos-grid' => {
    'cli' => {
      'version' => '0.4.14',
      'release_checksum' => '070587062c7c0b926e2438a383b05c942e99ccf909421feed4941d06e3846fa7',
      'auto_upgrade' => true,
      'install_path' => '/usr/local/bin/dcos',
    },
  },
)
```

- `roles/dcos0-universe-server.rb`

```ruby
cluster_name = 'dcos0'

name "#{cluster_name}-universe-server"
description "#{cluster_name} universe server"

run_list(
  "role[#{cluster_name}]",
  'recipe[dcos-grid::universe-server]',
)

override_attributes(
  'dcos-grid' => {
    'universe-server' => {
      'docker-compose' => {
        'config' => {
          'version' => '2',
          'services' => {
            'universe' => {
              'image' => 'my_account/universe-server:my_tag',
              'ports' => [
                '8085:80',
              ],
            },
          },
        },
      },
    },
  },
)
```

### Upgrade DC/OS (ver. 0.4.3 or later)

- Update attributes about DC/OS release URL (`['dcos-grid']['dcos_release_url']`) and configurations (`['dcos-grid']['bootstrap']['config']`).

- execute `sudo chef-client` on each node.

- upgrade the boostrap node.

```
$ /opt/dcos-grid/bootstrap_upgrade.sh
```

- upgrade each follower master node at first, and then upgrade the leader master node.

```
$ /opt/dcos-grid/node_upgrade.sh master
```

- upgrade each agent node.

```
$ /opt/dcos-grid/node_upgrade.sh {slave|slave_public}
```

- commit the upgrade on the bootstrap node.

```
$ /opt/dcos-grid/bootstrap_upgrade.sh -c
```

### Uninstall DC/OS

Please log in each node and execute the following.

```
$ /opt/dcos-grid/uninstall.sh
```

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2016-2017, whitestar

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
