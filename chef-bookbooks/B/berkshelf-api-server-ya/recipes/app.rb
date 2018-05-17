#
# Cookbook Name:: berkshelf-api-server-ya
# Recipe:: app
#
# Copyright 2015-2016, whitestar
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

::Chef::Recipe.send(:include, BerkshelfAPIServerYA::Helper)

include_recipe 'berkshelf-api-server::app'

begin
  r = resources(runit_service: 'berks-api')
  r.cookbook 'berkshelf-api-server-ya'
end

# clear cache file
file "#{node[:berkshelf_api][:home]}/cerch" do
  action :delete
  notifies :restart, 'runit_service[berks-api]'
end

endpoints = node[:berkshelf_api][:config][:endpoints]
# deploy client keys from Chef Vault
endpoints.each {|endpoint|
  options = endpoint[:options]

  options.key?(:client_key_vault_item) || next

  item_conf = options[:client_key_vault_item]

  chef_gem_chef_vault
  require 'chef-vault'
  secret = ChefVault::Item.load(item_conf[:vault], item_conf[:name])

  if item_conf.key?(:env_context) && item_conf[:env_context] == true
    secret = secret[node.chef_environment]
  end

  if !item_conf[:key].nil? && !item_conf[:key].empty?
    item_conf[:key].split('/').each {|elm|
      secret = secret[elm]
    }
  end

  file options[:client_key] do
    content secret
    sensitive true
    owner node[:berkshelf_api][:owner]
    group node[:berkshelf_api][:group]
    mode 0400
  end
}
