# zabbix_agentd cookbook

Installs and configures Zabbix Agent.

## Requirements

- Debian 7+
- Ubuntu 12.04+
- Red Hat/CentOS/Scientific (6.0+ required) - "EL6-family"
- Fedora

### Chef

- Chef 11+

### Cookbooks

## Attributes

The following attributes are set based on the platform, see the `attributes/default.rb` file for default values.

- `node['zabbix_agentd']['version']` - version of Zabbix Agent to manage.

## Recipes

### default

Install the Zabbix Agent package.

## Usage

## License and Author

- Author:: Chris Duong (mailto:chrisduong83@gmail.com)).

This project is licensed under the MIT license.
