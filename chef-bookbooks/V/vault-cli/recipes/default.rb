#
# Cookbook Name:: vault-cli
# Recipe:: default
#
# Copyright 2015, Peter Abbott
#
# All rights reserved - Do Not Redistribute
#

# just in case, centos is missing tar by default
package 'tar' do
  not_if { File.exist?(node['ark']['tar']) }
end

include_recipe 'java'

ark 'vault-cli' do
  action :install
  url node['vault_cli']['download_url']
  version node['vault_cli']['version']
  checksum node['vault_cli']['checksum'] if node['vault_cli']['checksum']
  has_binaries ['bin/vlt']
  action :install
end
