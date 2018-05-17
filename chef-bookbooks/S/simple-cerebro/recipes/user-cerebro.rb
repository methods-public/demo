#
# Cookbook Name:: simple-cerebro
# Recipe:: user-cerebro
#

user 'cerebro user' do
  username node['cerebro']['user']
  comment 'Cerebro User'
  home "#{node['cerebro']['dir']}/cerebro"
  shell '/bin/bash'
  supports manage_home: false
  action :create
  system true
end

group 'cerebro group' do
  group_name node['cerebro']['group']
  action :create
  system true
end
