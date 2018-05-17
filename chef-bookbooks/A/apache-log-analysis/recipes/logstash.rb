#
# Cookbook Name:: apache-log-analysis
# Recipe:: logstash
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
# #################### chamber-kibana ################
# https://supermarket.chef.io/cookbooks/logstash#readme
node.default['logstash']['instance_default']['version']        = '1.4.2'
node.default['logstash']['instance_default']['java_home']  = '/usr/lib/jvm/java-7-openjdk-amd64'

include_recipe 'logstash::server'
include_recipe 'logstash::agent'
# #####################################################
