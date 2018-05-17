#
# Cookbook Name:: apache-log-analysis
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
include_recipe 'apache-log-analysis::elasticsearch'
include_recipe 'apache-log-analysis::kibana'

# TODO: only enable logstash in log agent machines
include_recipe 'apache-log-analysis::logstash'
