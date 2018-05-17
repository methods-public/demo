#
# Cookbook Name:: fedora-mock
# Recipe:: default
#

# include EPEL
include_recipe 'yum-epel' if node['fedora-mock']['enable-epel']

# install mock
package 'mock'

# install mock plugins
node['fedora-mock']['plugins'].select { |_plugin, is_included| is_included }.keys.each do |plugin|
  package "mock-#{plugin}"
end

# immediately add users to mock group
execute :newgrp do
  command 'newgrp mock'
  action :nothing
end

# configure mock users
group 'mock' do
  members node['fedora-mock']['users'].select { |_user, is_included| is_included }.keys.sort
  action :modify
  notifies :run, 'execute[newgrp]', :immediately
end
