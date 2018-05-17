#
# Cookbook:: rancher-ha
# Recipe:: db
#
# Copyright:: 2018, Aaron Jones, All Rights Reserved.

# Fetch DB Password from Vault
include_recipe 'chef-vault'
credentials = chef_vault_item(:rancher, 'database')
node.default['database']['db_password'] = credentials['db_password']

# Pull db image
docker_image node['rancher']['db']['image'] do
  tag node['rancher']['db']['version']
  action :pull
end

# Run Rancher db container
docker_container 'rancher-db' do
  image node['rancher']['db']['image']
  tag node['rancher']['db']['version']
  container_name 'rancher-db'
  restart_policy 'unless-stopped'
  env "MYSQL_ROOT_PASSWORD=#{node['database']['db_password']}"
  action :run
end
