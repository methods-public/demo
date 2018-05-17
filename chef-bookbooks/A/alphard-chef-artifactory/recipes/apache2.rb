#
# Cookbook Name:: alphard-chef-artifactory
# Recipe:: apache2
#
# Copyright 2016, Hydra Technologies, Inc
#
# All rights reserved - Do Not Redistribute
#

artifactory = node['alphard']['artifactory']
user = artifactory['user']
group = artifactory['group']
fqdn = artifactory['apache2']['fqdn']
port = artifactory['apache2']['port']
url = "http://#{fqdn}"
url = "#{url}:#{port}" if !port.nil? && port != 80
email = artifactory['apache2']['email']
template_file = artifactory['apache2']['file']
file = "#{node['apache']['dir']}/sites-available/#{fqdn}.conf"

include_recipe 'alphard-chef-artifactory'
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy_ajp'

# Creates virtual host file from default template
template file do
  source template_file
  owner user
  group group
  mode '0644'
  variables fqdn: fqdn,
            port: port,
            url: url,
            email: email
end

# Enables site
apache_site fqdn do
  enable true
end

# Restarts apache
service 'apache2' do
  action :restart
end
