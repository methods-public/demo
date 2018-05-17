# Snu-Sumologic Cookbook CHANGELOG

This file is used to list changes made in each version of the snu-sumologic
cookbook.

## 3.0.1 (2018-04-13)

- Pin the apt cookbook to < 7

## 3.0.0 (2018-03-07)

- Refactor the source accumulator to use the run state as an intermediary
- Identify collector:source relationships by their directory on the filesystem
- Restore support for declaring a source resource with no matching collector
- Remove the snu_sumo_source_local_file resource's collector property

## 2.0.1 (2018-02-08)

- Reload Systemd in the :remove as well as :install action

## 2.0.0 (2018-01-29)

- Refactor the source accumulator to accumulate at compile time
- Make the installation and configuration recipes use one collector resource
- Change the collector resource's default action to include enable/start/manage
- Drop the collector resource's `:install_and_configure` action
- Use true/false in resource properties instead of TrueClass/FalseClass

## 1.2.0 (2017-10-25)

- Use the Chef node name instead of FQDN for the collector name

## 1.1.0 (2017-10-04)

- Default the hostName property to the FQDN

## 1.0.0 (2017-08-21)

- Refactor based on the newer sumologic-collector community cookbook

## 0.3.1 (2017-08-23)

- Replace sources with syncSources in config validator

## 0.2.8 (2017-08-21)

- Make the sensu user a member of the sumologic_collector group

## 0.2.5 (2017-08-11)

- Open up the sumologic-collector version dep a little

## 0.2.3 (2016-11-01)

- Remove duplicate collector attributes

## 0.1.100 (2015-08-25)

- Ensure the `rest-client` gem is installed before attempting to import it
