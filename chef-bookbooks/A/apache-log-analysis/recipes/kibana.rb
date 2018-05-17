#
# Cookbook Name:: apache-log-analysis
# Recipe:: kibana
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
# #################### chamber-kibana ################
# https://supermarket.chef.io/cookbooks/chamber-kibana#readme
node.default['kibana']['version'] = '4.0.0-beta3'
node.default['kibana']['dependency']['install_java'] = false
node.default['kibana']['dependency']['install_elasticsearch'] = false
include_recipe 'chamber-kibana'
# #####################################################
