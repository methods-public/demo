#
## Cookbook Name:: configure_and_deploy_ssc
## Recipe:: rhel_install_java
##
## Copyright (c) 2016 The Authors, All Rights Reserved.
#

# Installs the Oracle Java Runtime. 
# At the moment this recipe is pretty much empty, but there could be a situation where
# the java installation needs to be modified or the currently used cookbook relied upon
# is replaced by a differet one. This helps to keep things a little more modular
include_recipe 'java::oracle'
