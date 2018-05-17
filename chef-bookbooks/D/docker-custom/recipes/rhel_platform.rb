#
# Cookbook:: docker-custom
# Recipe:: rhel_platform
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'chef-yum-docker::default'

package 'docker-ce'
