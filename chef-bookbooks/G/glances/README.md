# glances Cookbook | [![Cookbook Version](https://img.shields.io/cookbook/v/glances.svg)](https://community.opscode.com/cookbooks/glances) [![Build Status](https://travis-ci.org/sliim-cookbooks/glances.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/glances) 

Installs/Configures [glances](http://nicolargo.github.io/glances/) on your server!

## Requirements

#### cookbooks
- `poise-python`

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen:
- `Ubuntu 12.04`
- `Ubuntu 14.04`
- `Debian 6`
- `Debian 7`
- `Debian 8`
- `Debian 9`
- `Centos 5`
- `Centos 6`
- `Centos 7`
- `Fedora 20`
- `Fedora 21`

#### Recommended cookbooks
- `apt` for debian/ubuntu platforms
- `build-essential` for all platforms

## Attributes

#### glances::default
|               Key               |  Type   |                 Description                  |
| ------------------------------- | ------- | -------------------------------------------- |
| `[glances][extra_pip_packages]` | Array   | List of extra packages (default: [pystache]) |
| `[glances][version]`            | String  | Glances package version (default: nil)       |
| `[glances][config]`             | Hash    | Glances configuration                        |

#### glances::service
|          Key         | Type |           Description          |
| -------------------- | ---- | ------------------------------ |
| `[glances][service]` | Hash | Hash for service configuration |

## Usage

#### glances::default

Just include `glances` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[glances]"
  ]
}
```

#### glances::service

Just include `glances::service` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[glances::service]"
  ]
}
```

This recipe is not compatible with Fedora.

### Examples

#### Glances with python 2.6
```json
{
  "json_class": "Chef::Role",
  "chef_type": "role",
  "name":"glances-py26",
  "description": "Glances with python 2.6",
  "run_list": [
    "recipe[glances]"
  ],
  "attributes": {
    "glances": {
      "extra_pip_packages": [
        "logutils",
        "argparse"
      ]
    }
  }
}
```

#### Glances server
```json
{
  "json_class": "Chef::Role",
  "chef_type": "role",
  "name":"glances-server",
  "description": "Glances server",
  "run_list": [
    "recipe[glances::service]"
  ],
  "attributes": {
    "glances": {
      "service": {
        "RUN": "true",
        "DAEMON": "/usr/local/bin/glances",
        "DAEMON_ARGS": "-s -B 127.0.0.1 -p 1337"
      }
    }
  }
}
```

#### Glances client
```json
{
  "json_class": "Chef::Role",
  "chef_type": "role",
  "name":"glances-client",
  "description": "Glances client",
  "run_list": [
    "recipe[glances]"
  ],
  "attributes": {
    "glances": {
      "config": {
        "serverlist": {
          "server_1_name": "10.0.0.4",
          "server_1_alias": "Server 1",
          "server_1_port": "1337",
          "server_2_name": "10.0.0.5",
          "server_2_alias": "Server 2",
          "server_2_port": "1338"
        }
      }
    }
  }
}
```

#### Glances process monitor
```json
{
  "json_class": "Chef::Role",
  "chef_type": "role",
  "name":"glances-proc-monitor",
  "description": "Glances process monitoring",
  "run_list": [
    "recipe[glances]"
  ],
  "attributes": {
    "glances": {
      "config": {
        "monitor": {
          "list_1_description": "Glances",
          "list_1_regex": ".*/usr/local/bin/glances",
          "list_1_countmin": "1",
          "list_1_countmax": "1"
        }
      }
    }
  }
}
```

#### Glances libnotify
```json
{
  "json_class": "Chef::Role",
  "chef_type": "role",
  "name":"glances-libnotify",
  "description": "Glances libnotify",
  "run_list": [
    "recipe[glances]"
  ],
  "attributes": {
    "glances": {
      "config": {
        "sensors": {
          "battery_critical_action": "notify-send -u critical -i terminal BAT \"Critical: {{label}} {{value}}%%\"",
          "battery_warning_action": "notify-send -u normal -i terminal BAT \"Warning: {{label}} {{value}}%%\"",
          "battery_careful_action": "notify-send -u low -i terminal BAT \"Careful: {{label}} {{value}}%%\"",
          "temperature_core_critical_action": "notify-send -u critical -i terminal TEMP \"Critical: Core {{label}} - {{value}}\u00b0C\"",
          "temperature_core_warning_action": "notify-send -u normal -i terminal TEMP \"Warning: Core {{label}} - {{value}}\u00b0C\"",
          "temperature_core_careful_action": "notify-send -u low -i terminal TEMP \"Careful: Core {{label}} - {{value}}\u00b0C\""
        },
        "fs": {
          "critical_action": "notify-send -u critical -i terminal FileSystem \"Critical: {{mnt_point}} - {{percent}}%% used\"",
          "warning_action": "notify-send -u normal -i terminal FileSystem \"Warning: {{mnt_point}} - {{percent}}%% used\"",
          "careful_action": "notify-send -u low -i terminal FileSystem \"Careful: {{mnt_point}} - {{percent}}%% used\""
        },
        "memswap": {
          "critical_action": "notify-send -u critical -i terminal SWAP \"Critical: {{percent}}%%\"",
          "warning_action": "notify-send -u normal -i terminal SWAP \"Warning: {{percent}}%%\"",
          "careful_action": "notify-send -u low -i terminal SWAP \"Careful: {{percent}}%%\""
        },
        "mem": {
          "critical_action": "notify-send -u critical -i terminal MEMORY \"Critical: {{percent}}%%\"",
          "warning_action": "notify-send -u normal -i terminal MEMORY \"Warning : {{percent}}%%\"",
          "careful_action": "notify-send -u low -i terminal MEMORY \"Careful : {{percent}}%%\""
        },
        "load": {
          "critical_action": "notify-send -u critical -i terminal LOAD \"Critical: {{min1}} - {{min5}} - {{min15}}\"",
          "warning_action": "notify-send -u normal -i terminal LOAD \"Warning: {{min1}} - {{min5}} - {{min15}}\"",
          "careful_action": "notify-send -u low -i terminal LOAD \"Careful: {{min1}} - {{min5}} - {{min15}}\""
        },
        "cpu": {
          "steal_critical_action": "notify-send -u critical -i terminal CPU \"Critical steal: {{steal}}%%\"",
          "steal_warning_action": "notify-send -u normal -i terminal CPU \"Warning steal: {{steal}}%%\"",
          "steal_careful_action": "notify-send -u low -i terminal CPU \"Careful steal: {{steal}}%%\"",
          "iowait_critical_action": "notify-send -u critical -i terminal CPU \"Critical iowait: {{iowait}}%%\"",
          "iowait_warning_action": "notify-send -u normal -i terminal CPU \"Warning iowait: {{iowait}}%%\"",
          "iowait_careful_action": "notify-send -u low -i terminal CPU \"Careful iowait: {{iowait}}%%\"",
          "system_critical_action": "notify-send -u critical -i terminal CPU \"Critical system: {{system}}%%\"",
          "system_warning_action": "notify-send -u normal -i terminal CPU \"Warning system: {{system}}%%\"",
          "system_careful_action": "notify-send -u low -i terminal CPU \"Careful system: {{system}}%%\"",
          "user_critical_action": "notify-send -u critical -i terminal CPU \"Critical user: {{user}}%%\"",
          "user_warning_action": "notify-send -u normal -i terminal CPU \"Warning user: {{user}}%%\"",
          "user_careful_action": "notify-send -u low -i terminal CPU \"Careful user: {{user}}%%\""
        }
      }
    }
  }
}
```

## Testing

You can use `rake` to invoke testing tasks (See `Rakefile` for details):

##### Checkstyle
```
$ rake test:checkstyle
```

Will run `foodcritic` and `cookstyle`.

##### Chefspec
```
$ rake test:chefspec
```

Will run unit tests with `ChefSpec`.

##### Kitchen
```
$ rake test:kitchen
```

Will test all kitchen instances declared in `.kitchen.yml`.

Docker driver is used for integration testing with `test-kitchen`. You will need to have `docker` installed to run integration testing, or adapt the existing `.kitchen.yml` for your driver.

```
$ kitchen list
$ kitchen test [instance]
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: Sliim <sliim@mailoo.org>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

