# Description

This cookbook will setup a bridge on the chef server for rundeck.
See https://github.com/oswaldlabs/chef-rundeck for more information on how to configure the bridge.

Most of the config is still left to the user and has to be done in a wrapper cookbook, including:
- bridge definitions
- chef server access through knife.rb configuration
- chef user definition on the chef server

# Requirements

## Platform:

* Centos

## Cookbooks:

* chef-client
* poise-service
* rundeck-server (Suggested but not required)
* rundeck-node (Suggested but not required)

# Attributes

Name | Description | Default
-----|-------------|--------
* `node['rundeck_bridge']['user']` | Service user on bridge. |Defaults to `"chef-rundeck"`.
* `node['rundeck_bridge']['group']` |  |Defaults to `"chef-rundeck"`.
* `node['rundeck_bridge']['home']` | Home of service user. |Defaults to `"/home/chef-rundeck"`.
* `node['rundeck_bridge']['binary']` | Location of chef-rundeck gem binary. |Defaults to `"/opt/chef/embedded/bin/chef-rundeck"`.
* `node['rundeck_bridge']['options']['host']` | IP to bind the bridge to. |Defaults to `"0.0.0.0"`.
* `node['rundeck_bridge']['options']['port']` | Port the bridge listens to. |Defaults to `"9980"`.
* `node['rundeck_bridge']['options']['partial-search']` | Lighten load on chef-server using partial search instead of classic search. |Defaults to `"true"`.
* `node['rundeck_bridge']['options']['username']` | Default username attribute for the node element in the generated resource xml. |Defaults to `"rundeck"`.

# Recipes

* rundeck-bridge::install
* rundeck-bridge::config
* rundeck-bridge::service
* [rundeck-bridge::default](#rundeck-bridgedefault)

## rundeck-bridge::default

This recipe call config recipe and setup a chef-rundeck service that host all bridges

# License and Maintainer

Maintainer:: Robert Veznaver (<r.veznaver@criteo.com>)

License:: Apache License 2.0
