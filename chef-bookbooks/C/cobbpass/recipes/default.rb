#
# Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
# Cookbook Name:: cobbpass
# Recipe:: default
#
# Copyright 2017, Movile
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'chef-vault'

# install ruby-shadow for dealing with shadow secrets
if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  chef_gem 'ruby-shadow' do # ~FC009
    options node['cobbpass']['gem_options']
    source node['cobbpass']['gem_source']
    version node['cobbpass']['gem_version']
    clear_sources true unless node['cobbpass']['gem_source'].nil?
    compile_time true
  end
else
  chef_gem 'ruby-shadow' do
    options node['cobbpass']['gem_options']
    source node['cobbpass']['gem_source']
    version node['cobbpass']['gem_version']
    clear_sources true unless node['cobbpass']['gem_source'].nil?
    action :nothing
  end.run_action(:install)
end

# user and home
group node['cobbpass']['username'] do
  gid node['cobbpass']['gid']
end

user node['cobbpass']['username'] do
  uid node['cobbpass']['uid']
  gid node['cobbpass']['gid']
  system true
  comment 'Cobbpass User'
  manage_home true
end

directory node['cobbpass']['home'] do
  owner node['cobbpass']['username']
  group node['cobbpass']['username']
  mode 0700
end

directory "#{node['cobbpass']['home']}/.ssh" do
  owner node['cobbpass']['username']
  group node['cobbpass']['username']
  mode 0700
end

# this user must always login with password
file "#{node['cobbpass']['home']}/.ssh/authorized_keys" do
  action :delete
end

# sudoers permissions
sudo 'cobbpass' do
  user node['cobbpass']['username']
  nopasswd false
  commands [ 'ALL' ]
end

# check if the databag exists
begin
  data_bag(node['cobbpass']['vault_name'])
rescue
  raise "Cobbpass databag doesn't exist. Please see README.md on how to create it"
end

# generate a random password and change
require 'securerandom'
password = SecureRandom.base64(48)
shadow_password = password.crypt('$6$' + SecureRandom.random_number(36 ** 8).to_s(36))

client_admins = node['cobbpass']['vault_client_admin'].join(' OR name:')

begin
  previous_password = chef_vault_item(node['cobbpass']['vault_name'], node['cobbpass']['vault_item'])
  previous_password = previous_password['current']
rescue
  previous_password = 'none'
end

user 'cobbpass password' do
  username node['cobbpass']['username']
  password shadow_password
  notifies :create, 'chef_vault_secret[cobbpass vault]', :immediately
end

chef_vault_secret 'cobbpass vault' do
  action :nothing
  id node['cobbpass']['vault_item']
  data_bag node['cobbpass']['vault_name']
  admins []
  clients "name:#{node['cobbpass']['vault_item']} OR name:#{client_admins}"
  search "name:#{node['cobbpass']['vault_item']} OR name:#{client_admins}"
  raw_data({'current' => password, 'previous' => previous_password})
end
