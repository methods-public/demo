#
# Cookbook Name:: berkshelf-api-server-ya
# Recipe:: http_proxy
#
# Copyright 2015, whitestar
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

include_recipe 'berkshelf-api-server::http_proxy'

begin
  res = resources(template: "#{node[:nginx][:dir]}/sites-available/berks-api")
  res.cookbook 'berkshelf-api-server-ya'
end

if node[:berkshelf_api][:proxy].key?(:ssl_certificate_key_vault_item)
  item_conf = node[:berkshelf_api][:proxy][:ssl_certificate_key_vault_item]

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

  key_path = node[:berkshelf_api][:proxy][:ssl_certificate_key]
  res = (
    resources(file: key_path) rescue file key_path do
      content secret
      sensitive true
      owner 'root'
      group 'root'
      mode 0400
    end
  )
  res.notifies(:reload, 'service[nginx]', :delayed)
end
