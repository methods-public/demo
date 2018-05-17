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

    apt_repository "wazuh" do
        uri "https://packages.wazuh.com/apt"
        distribution node['lsb']['codename']
        components ['main']
        keyserver 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
        action :add
    end

    %w(apt apt-transport-https lsb-release).each do |pkg|
        package pkg do
            action :install
        end
    end

when 'rhel'

    include_recipe 'yum'

    case node['platform']
    when 'centos'
        yum_repository "wazuh" do
            description "Configures Wazuh repository"
            baseurl 'https://packages.wazuh.com/yum/el/$releasever/$basearch'
            gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
            gpgcheck true
            enabled true
            action :create
        end

    when 'rhel'
        yum_repository "wazuh" do
            description "Configures Wazuh repository"
            baseurl 'https://packages.wazuh.com/yum/rhel/$releasever/$basearch'
            gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
            gpgcheck true
            enabled true
            action :create
        end
    when 'fedora'
        yum_repository "wazuh" do
            description "Configures Wazuh repository"
            baseurl 'https://packages.wazuh.com/yum/fc/$releasever/$basearch'
            gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
            gpgcheck true
            enabled true
            action :create
        end
    when 'amazon'
        yum_repository "wazuh" do
            description "Configures Wazuh repository"
            baseurl 'https://packages.wazuh.com/yum/el/7/$basearch'
            gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
            gpgcheck true
            enabled true
            action :create
        end
    end

end