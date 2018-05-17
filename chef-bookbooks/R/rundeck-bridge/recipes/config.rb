#
# Cookbook: rundeck-bridge
# Recipe:   config
#

# Include chef-client to make sure the client.rb is there
include_recipe 'chef-client::config'

# chef-rundeck bug https://github.com/oswaldlabs/chef-rundeck/issues/27
file '/etc/chef/client.d/chef-rundeck.rb' do
  owner   'root'
  group   'root'
  mode    '0644'
  content 'log_level :info'
  notifies :restart, 'poise_service[chef-rundeck]'
end
