# chef_wazuh

Installs and configures [Wazuh](https://wazuh.com/) on Linux.

# OS Support:

* Ubuntu  >= 16.04
* Debian  >= 7.0
* RedHat  >= 7.0
* CentOS  >= 7.0

# Usage

## Server:

##### Coming soon...

## Agent:

### chef_wazuh::agent

Just include `chef_wazuh::agent` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef_wazuh::agent]"
  ]
}
```

This will install the Wazuh agent and manage it's configuration going forward.

## Attributes 

##### Note: see `attributes/` for all attributes.

### Wazuh Server:

The Wazuh server the agent should connect to.

Default Value: 

- `nil`

Ruby usage:

```ruby
node['chef_wazuh']['agent']['server'] = "wazuh.domain.tld"
```

JSON usage:

```json
{
  "chef_wazuh": {
    "agent": {
      "server": "wazuh.domain.tld"
    }
  }
}
```

### OSSEC Configuration File:

The OSSEC configuration file location.

Default Value: 

- `/var/ossec/etc/ossec.conf`

Ruby usage:

```ruby
node['chef_wazuh']['agent']['ossec_conf_path'] = "/opt/ossec/etc/ossec.conf"
```

JSON usage:

```json
{
  "chef_wazuh": {
    "agent": {
      "ossec_conf_path": "/opt/ossec/etc/ossec.conf"
    }
  }
}
```

### OSSEC Server Address:

The address of the OSSEC server.

Default Value: 

- `nil`

Ruby usage:

```ruby
node['chef_wazuh']['agent']['ossec_config']['client']['server']['address'] = "wazuh.domain.tld"
```

JSON usage:

```json
{
  "chef_wazuh": {
    "agent": {
      "ossec_config": {
        "client": {
          "server": {
            "address": "wazuh.domain.tld"
          }
        }
      }
    }
  }
}
```

### OSSEC Port:

The OSSEC port.

Default Value: 

- `1514`

Ruby usage:

```ruby
node['chef_wazuh']['agent']['ossec_config']['client']['server']['port'] = 1515
```

JSON usage:

```json
{
  "chef_wazuh": {
    "agent": {
      "ossec_config": {
        "client": {
          "server": {
            "port": 1515
          }
        }
      }
    }
  }
}
```

### OSSEC Protocol:

The OSSEC protocol.

###### Needs to be "tcp" or "udp", default value is "udp" if omitted.

Default Value: 

- `udp`

Ruby usage:

```ruby
node['chef_wazuh']['agent']['ossec_config']['client']['server']['protocol'] = "tcp"
```

JSON usage:

```json
{
  "chef_wazuh": {
    "agent": {
      "ossec_config": {
        "client": {
          "server": {
            "protocol": "tcp"
          }
        }
      }
    }
  }
}
```