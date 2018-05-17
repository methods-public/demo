#
# Cookbook Name:: azurecli
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['azurecli']['azure']['version']
when '1'
  include_recipe 'azurecli::_azure_nodejs'
when '2'
  include_recipe 'azurecli::_azure_python'
else
  include_recipe 'azurecli::_azure_python'
  include_recipe 'azurecli::_azure_nodejs'
end
