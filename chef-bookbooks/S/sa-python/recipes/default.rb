#
# Cookbook Name:: sa-java
# Recipe:: default
#

include_recipe 'sa-python::install_yum' if platform?('redhat', 'centos', 'fedora')

include_recipe 'sa-python::install_apt' if platform?('ubuntu')
