#
# Cookbook:: stegosoc
# Recipe:: wazuh_repo
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.

Chef::Log.info("Platform family: #{node['platform_family']}")
Chef::Log.info("Platform: #{node['platform']}")

case node['platform_family']
when 'debian'
    include_recipe 'apt'

    apt_repository "elasticsearch-2.x" do
        uri "http://packages.elastic.co/elasticsearch/2.x"
        distribution node['lsb']['codename']
        components ['main']
        action :add
    end

    %w(apt apt-transport-https lsb-release).each do |pkg|
        package pkg do
            action :install
        end
    end
end
