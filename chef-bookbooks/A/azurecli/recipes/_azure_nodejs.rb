#
# Cookbook Name:: azurecli::_azure_nodejs
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'nodejs'
nodejs_npm 'azure-cli'

cookbook_file '/etc/profile.d/azure_completion.sh' do
  source 'azure_completion.sh'
  user   'root'
  group  'root'
  mode   '0644'
end
