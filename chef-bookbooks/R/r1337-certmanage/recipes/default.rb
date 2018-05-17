#
# Cookbook Name:: r1337-certmanage
# Recipe:: default
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe just calls the other recipes in this cookbook in the correct order, in order to deploy the certificates and keys

# Include the required gem for chef-vault
chef_gem "chef-vault"
require "chef-vault"

# This recipe will configure the base requirements for Route 1337 style SSL certificate management
include_recipe 'r1337-certmanage::prereqs'
# This recipe will deploy the SSL certificates and their corresponding keys from Chef Vault
include_recipe 'r1337-certmanage::certdeploy'
# This recipe will perform cleanup of removed certs and keys as well as unmanaged files'
include_recipe 'r1337-certmanage::maintenance'