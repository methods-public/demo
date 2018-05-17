#
# Cookbook:: docker-custom
# Recipe:: ubuntu_platform
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'chef-apt-docker::default'

package 'docker-ce'
