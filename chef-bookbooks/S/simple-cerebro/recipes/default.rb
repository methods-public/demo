#
# Cookbook Name:: simple-cerebro
# Recipe:: default
#

include_recipe 'simple-cerebro::user-cerebro'
include_recipe 'simple-cerebro::install-cerebro'
include_recipe 'simple-cerebro::configure-cerebro'
include_recipe 'simple-cerebro::service_runit-cerebro'
