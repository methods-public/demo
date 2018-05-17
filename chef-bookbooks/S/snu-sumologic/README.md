# Snu-Sumologic Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/snu-sumologic.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/socrata-cookbooks/snu-sumologic.svg)][travis]
[![Coverage Status](https://img.shields.io/coveralls/socrata-cookbooks/snu-sumologic.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/snu-sumologic
[travis]: https://travis-ci.org/socrata-cookbooks/snu-sumologic
[coveralls]: https://coveralls.io/r/socrata-cookbooks/snu-sumologic

An opinionated implementation of installation and configuration of the Sumo
Logic collector using the sumologic-collector cookbook.

## Requirements

This cookbook requires at least Chef 12. It is continuously tested against
various OS and Chef combinations:

- Chef (13, 12)

X

- Ubuntu (16.04, 14.04)
- Debian (8)
- RHEL (7, 6)
- Fedora (27)

It expects to find Sumo Logic API credentials in a data bag item named
`sumologic` within a data bag named `credentials`. That data bag item must
contain keys for both `accessID` and `accessKey`.

## Usage

Add one or more of the included recipes to your run list and/or declare
instances of the included resources in your own recipes.

## Recipes

***default***

* Runs the installation, configuration, and monitoring recipes.

***installation***

* Uses the `snu_sumologic_collector` resource to install the collector app,
  unconfigured, into `/opt/SumoCollector`.
* This recipe performs no configuration and is ideal for e.g. baking the Sumo
  collector into a base system image.

***configuration***

* Pulls Sumo Logic credentials out of the configured credentials data bag.
* Uses the `snu_sumologic_collector` resource to configure and start the
  collector that should have already been installed by the `installation`
  recipe, and delete any Sumo sources that are no longer in Chef's resource
  collection.

***monitoring***

* Ensures Sensu is installed and makes the sensu user a member of the Sumo
  group so it's able to monitor logs in `/opt/SumoCollector`.
* At some point in the future, this recipe will include configuring Sensu
  checks for the Sumo collector.

## Attributes

***default***

The `configuration` recipe pulls Sumo credentials out of a data bag that is
configurable via two attributes:

    default['sumologic']['credentials']['bag_name'] = 'credentials'
    default['sumologic']['credentials']['item_name'] = 'sumologic'

An empty config hash is defined that can be overridden to pass any additional
properties to the `snu_sumologic_collector` resource in the `configuration`
recipe:

    default['snu_sumologic']['config'] = {}

## Resources

***snu_sumologic_collector***

A wrapper around the `sumologic_collector` resource to:

* Set some opinionated defaults based on our Sumo usage.
* Manage the configured Sumo sources directory.

Syntax:

    snu_sumologic_collector 'default' do
      sumo_access_id 'abc123'
      sumo_access_key 'def456'
      action %i[install configure enable start manage]
    end

Actions:

| Action                   | Description                              |
|--------------------------|------------------------------------------|
| `:install`               | Install the collector, unconfigured      |
| `:configure`             | Configure an installed collector         |
| `:manage`                | Delete no-longer-configured Sumo sources |
| `:remove`                | Uninstall the collector                  |
| `:start`                 | Start the collector                      |
| `:stop`                  | Stop the collector                       |
| `:restart`               | Restart the collector                    |
| `:enable`                | Enable the collector                     |
| `:disable`               | Disable the collector                    |

\* The `:manage` action works by using an accumulator pattern to have each
   `snu_sumologic_source_*` resource register itself in the node's run state.
   A source is considered to belong to the collector with a `sync_sources`
   property that matches its `source_json_directory` property.

\* The `:manage` action works by using an accumulator pattern to have each
   `snu_sumologic_source_*` resource register itself with the collector at
   compile time. The collector is then able to delete any sources on the
   filesystem that are no longer being declared in Chef.

Properties:

| Property                | Default                 | Description                                   |
|-------------------------|-------------------------|-----------------------------------------------|
| sumo_access_id          | `nil`                   | Needed for the `:configure` action            |
| sumo_access_key         | `nil`                   | Needed for the `:configure` action            |
| dir                     | `'/opt/SumoCollector`   | Set a default install dir                     |
| collector_name          | `node.name`             | Set it to the unique Chef node name           |
| sync_sources            | `'/etc/sumo.d'`         | Assume a .d-style sources configuration       |
| ephemeral               | `true`                  | Set a cloud-friendly default                  |
| clobber                 | `true`                  | Set a cloud-friendly default                  |
| runas_username          | `'root'`                | Work around a bug in the Sumo install script  |
| wrapper_java_initmemory | 256                     | Set larger defaults for the Java heap size    |
| wrapper_java_maxmemory  | 256                     | Set larger defaults for the Java heap size    |
| sources                 | Read from the run state | A list of sources belonging to this collector |
| \*                      | \*                      | \*                                            |

\* All other properties are identical to those in the `sumologic_collector`
   [resource](https://github.com/SumoLogic/sumologic-collector-chef-cookbook#sumologic_collector).

***snu_sumo_source_local_file***

A wrapper around the `sumo_source_local_file` resource to:

* Register each source in the node's run state to enable accumulation and
  management from a collector resource.
* Set some opinionated defaults based on our Sumo usage.
* Define an additional `:delete` action.

Syntax:

    snu_sumo_source_local_file 'nginx' do
      path_expression '/var/log/nginx.log'
      action :create
    end

Actions:

| Action    | Description                         |
|-----------|-------------------------------------|
| `:create` | Create a config file for the source |
| `:delete` | Delete the source's config file     |

Properties:

| Property              | Default         | Description                                   |
|-----------------------|-----------------|-----------------------------------------------|
| source_json_directory | `'/etc/sumo.d'` | The .d-style source config dir                |
| time_zone             | `'UTC'`         | Default all logs to UTC                       |
| force_time_zone       | `true`          | Force logs to be parsed into UTC              |
| \*                    | \*              | \*                                            |

\* All other properties are identical to those in the `sumo_source_local_file`
   [resource](https://github.com/SumoLogic/sumologic-collector-chef-cookbook#sumo_source_local_file).

## Maintainers

- Jonathan Hartman <jonathan.hartman@socrata.com>
- Joe Nunnelley <joe.nunnelley@socrata.com>
- Andrew Gall <andrew.gall@socrata.com>
- Ayn Leslie <ayn.leslie@socrata.com>
