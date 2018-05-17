#
# Cookbook:: aerospike
# Recipe:: default
#
include_recipe 'aerospike::install'
include_recipe 'aerospike::conf'
include_recipe 'aerospike::service'
