#
# Cookbook: redhat
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
return unless platform_family?('rhel')

include_recipe 'yum::default'
include_recipe 'yum-centos::default' if platform?('centos')
include_recipe 'yum-amazon::default' if platform?('amazon')
include_recipe 'yum-epel::default' if node['redhat']['enable_epel']
