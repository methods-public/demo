#
# Cookbook:: docker-custom
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.





if node['platform'] == 'ubuntu'
  include_recipe 'docker-custom::ubuntu_platform'
elsif node['platform'] == 'centos' || node['platform'] == 'rhel' || node['platform'] == 'fedora'
  include_recipe 'docker-custom::rhel_platform'
elsif node['platform'] == 'debian'
  include_recipe 'docker-custom::deb_platform'
end


#Installs curl and docker compose
package 'curl'

execute "sudo curl -L #{node['docker-compose']['url']}-`uname -s`-`uname -m` -o #{node['docker-compose']['bin']}"

file node['docker-compose']['bin'] do
  mode '755'
end
