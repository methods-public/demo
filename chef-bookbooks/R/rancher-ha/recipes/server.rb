#
# Cookbook:: rancher-ha
# Recipe:: server
#
# Copyright:: 2018, Aaron Jones, All Rights Reserved.

# Fetch DB Password from Vault
include_recipe 'chef-vault'
credentials = chef_vault_item(:rancher, 'database')
node.default['database']['db_password'] = credentials['db_password']

# Pull Rancher server image
docker_image node['rancher']['server']['image'] do
  tag node['rancher']['server']['version']
  action :pull
end

# Run Rancher server container
docker_container 'rancher-server' do
  image node['rancher']['server']['image']
  tag node['rancher']['server']['version']
  container_name 'rancher-server'
  restart_policy 'unless-stopped'
  port ["#{node['rancher']['server']['listening_port']}:8080", '9345:9345']
  links ["rancher-db:#{node['rancher']['db']['dbhost']}"]
  command "--advertise-address #{node['ipaddress']} --db-host #{node['rancher']['server']['dbhost']} --db-port #{node['rancher']['server']['dbport']} --db-user #{node['rancher']['server']['dbuser']} --db-pass #{node['database']['db_password']} --db-name #{node['rancher']['server']['dbname']}"
  action :run
end
