#
# Cookbook Name:: dante_ng
# Recipe:: default
#
# Copyright 2018, Alexander Merkulov
#

include_recipe 'dante_ng::install'
include_recipe 'dante_ng::setup'
include_recipe 'dante_ng::service'
