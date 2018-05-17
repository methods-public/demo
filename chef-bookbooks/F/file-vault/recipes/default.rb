#
# Cookbook Name:: file-vault
# Recipe:: default
#

include_recipe 'chef-vault'

node['file-vault']['files'].each do |item_hash|
  data_bag = item_hash['bag'] || node['file-vault']['bag']
  secret_content = chef_vault_item(data_bag, item_hash['item'])

  file item_hash['name'] do
    content secret_content['file-content']
    owner item_hash['owner'] || 'root'
    group item_hash['group'] || 'root'
    mode item_hash['mode'] ||'0640'
  end
end
