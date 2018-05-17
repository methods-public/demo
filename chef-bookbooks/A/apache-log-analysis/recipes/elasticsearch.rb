#
# Cookbook Name:: apache-log-analysis
# Recipe:: elasticsearch
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
# #################### elasticsearch #######################
# https://supermarket.chef.io/cookbooks/elasticsearch#readme
node.default['java']['install_flavor'] = 'openjdk'
node.default['java']['jdk_version'] = '7'
include_recipe 'java'

node.default['elasticsearch']['cluster']['name'] = 'elasticsearch_test_chef'
node.default['elasticsearch']['version'] = '1.4.2'
include_recipe 'elasticsearch'
# #####################################################
