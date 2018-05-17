#
# Cookbook Name:: twindb-agent
# Recipe:: default
#

# Include the necessary recipe to install the twindb repository
include_recipe 'twindb-repo'

# Install the twindb package
package 'twindb-agent' do
  action :install
end

# Enable the twindb service and start it up
service 'twindb-agent' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
