#
# Cookbook Name:: systempatch
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'systempatch::patch-cve-2014-6271'
include_recipe 'systempatch::patch-cve-2014-0160'