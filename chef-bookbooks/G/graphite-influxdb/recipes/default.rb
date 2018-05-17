#
# Cookbook Name:: chef-graphite-influxdb
# Recipe:: default
#
# Copyright (C) 2016 Jarrett Hawrylak
#

include_recipe "graphite-api"
include_recipe "graphite-influxdb::install-deps"
include_recipe "graphite-influxdb::install-#{node['graphite_influxdb']['install_method']}"
include_recipe "graphite-influxdb::configure-graphite-api"
