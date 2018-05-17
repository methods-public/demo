#
# Cookbook:: rancher-ha
# Recipe:: nginx
#
# Copyright:: 2018, Aaron Jones, All Rights Reserved.

# Create Nginx config directory that will be bind mounted to the Nginx container
%w(/etc/nginx /etc/nginx/conf.d /etc/nginx/ssl).each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

# Generate self-signed certificate
openssl_x509 "/etc/nginx/ssl/#{node['fqdn']}.crt" do
  common_name node['fqdn']
  country node['nginx']['cert']['country']
  state node['nginx']['cert']['state']
  city node['nginx']['cert']['locality']
  org node['nginx']['cert']['org']
  org_unit node['nginx']['cert']['org_unit']
  expire node['nginx']['cert']['expiration']
end

# Generate host config
template "/etc/nginx/conf.d/#{node['fqdn']}.conf" do
  source 'default.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    server: node['fqdn'],
    cert_file: "#{node['nginx']['cert_dir']}/#{node['fqdn']}.crt",
    key_file: "#{node['nginx']['cert_dir']}/#{node['fqdn']}.key",
    access_log: "/var/log/nginx/#{node['fqdn']}.access.log",
    error_log: "/var/log/nginx/#{node['fqdn']}.error.log"
  )
end

# Pull Nginx server image
docker_image node['nginx']['server']['image'] do
  tag node['nginx']['server']['version']
  action :pull
end

# Run Nginx server container
docker_container 'nginx' do
  image node['nginx']['server']['image']
  tag node['nginx']['server']['version']
  container_name 'nginx'
  restart_policy 'unless-stopped'
  port ['443:443']
  volumes ["#{node['nginx']['dir']}/:/etc/nginx/conf.d", "#{node['nginx']['cert_dir']}:/etc/nginx/ssl/"]
  links ['rancher-server:rancher-server']
  command "nginx-debug -g 'daemon off;'"
  action :run
end
