# Deploy LogDNA Agent with Chef

## Description

Chef Cookbook to install and configure LogDNA Agent

## Requirements

Chef 12.1+

## Platforms Tested

* CentOS 6
* CentOS 7
* Ubuntu 12.04 - Precise
* Ubuntu 14.04 - Trusty
* Ubuntu 16.04 - Xenial
* Ubuntu 17.10 - Artful

## Attributes

Attributes have default values set in `attributes/default.rb`.

### Task-specific Attributes

* `node['logdna']['agent_install']`: Whether to install or not. Default is `true`
* `node['logdna']['agent_configure']`: Whether to configure or not. Default is `true`
* `node['logdna']['agent_service']`: How to manage LogDNA Agent Service. Default is `:start`. The possible values are:
  * `:start`: in order to start
  * `:stop`: in order to stop
  * `:restart`: in order to restart

### Configuration Attributes

* `node['logdna']['conf_key']`: LogDNA API Key - LogDNA Agent won't start unless `node['logdna']['conf_key']` is set
* `node['logdna']['conf_config']`: File Path for the LogDNA Agent configuration (defaults to `/etc/logdna.conf`)
* `node['logdna']['conf_logdir']`: Log Directories to be added
* `node['logdna']['conf_logfile']`: Log Files to be added
* `node['logdna']['conf_exclude']`: Log Files or Directories to be excluded
* `node['logdna']['conf_exclude_regex']`: Exclusion Rule for Log Lines
* `node['logdna']['conf_hostname']`: Alternative host name to be used
* `node['logdna']['conf_tags']`: Tags to be added

## Recipes

There are different recipes for doing each process for each kind of system; you can find all in `recipes/` folder.

### default

The default recipe is the main recipe calling all others depending on attributes and platform. There are the following cases:
* if `node['logdna']['agent_install']` is `true`, it will call `install_debian` or `install_redhat` depending on node's platform
* if `node['logdna']['agent_configure']` is set to `true`, it will call `configure` recipe
* if `node['logdna']['conf_key']` is set or `node['logdna']['agent_service']` is set to `:stop`, it will call `service_debian` or `service_redhat` depending on node's platform

### install_debian

The recipe to install LogDNA Agent onto `deb` or `apt` based systems.

### install_redhat

The recipe to install LogDNA Agent onto `rpm` or `yum` based systems.

### configure

The recipe to configure LogDNA Agent using `node['logdna']['conf_*']` attributes.

### service_debian

The recipe to enable and manage LogDNA Agent Service on `deb` or `apt` based systems.

### service_redhat

The recipe to enable and manage LogDNA Agent Service on `rpm` or `yum` based systems.

## Contributing

Contributions are always welcome. See the [contributing guide](https://github.com/logdna/chef-logdna/blob/master/CONTRIBUTING.md) to learn how you can help.

## License and Authors

* Author: [Samir Musali](https://github.com/ldsamir), LogDNA
* License: MIT
