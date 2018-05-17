#
# Cookbook: rundeck-bridge
# Recipe:   install
#

# Poise will create the User/Group but not the 'home' directory
poise_service_user node['rundeck_bridge']['user'] do
  home    node['rundeck_bridge']['home']
  group   node['rundeck_bridge']['group']
end

# Home directory for log
directory node['rundeck_bridge']['home'] do
  owner     node['rundeck_bridge']['user']
  group     node['rundeck_bridge']['group']
  mode      '0755'
  recursive true
end

# Install sinatra beta version
# Required to avoid the following issue for Chef >= 12.14.60
# https://github.com/Webtrends/rundeck/issues/100
chef_gem 'sinatra' do
  version '>= 2.0.0.beta2'
  only_if { Chef::Version.new(Chef::VERSION) >= Chef::Version.new('12.14.60') }
end

# Install chef-rundeck in chef as it requires chef
chef_gem node['rundeck_bridge']['gem']['name'] do
  compile_time false
  version node['rundeck_bridge']['gem']['version']
end
