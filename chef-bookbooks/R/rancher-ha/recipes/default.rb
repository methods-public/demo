#
# Cookbook:: rancher-ha
# Recipe:: default
#
# Copyright:: 2018, Aaron Jones, All Rights Reserved.

begin
    data_bag('rancher')
  rescue
    ruby_block 'create-data_bag-rancher' do
      block do
        Chef::DataBag.validate_name!('rancher')
        databag = Chef::DataBag.new
        databag.name('rancher')
        databag.save
      end
      action :run
    end
  end

# Create and start Docker service
docker_service 'default' do
  action [:create, :start]
end
