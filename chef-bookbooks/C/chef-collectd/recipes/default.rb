#
# Cookbook:: chef-collectd
# Recipe:: default
#

include_recipe 'chef-collectd::install'
include_recipe 'chef-collectd::config'
include_recipe 'chef-collectd::service'
