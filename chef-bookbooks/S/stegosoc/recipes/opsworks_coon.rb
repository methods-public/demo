#
# Cookbook:: stegosoc
# Recipe:: opsworks_coon
#
# Copyright:: 2017, Mayank Gaikwad, All Rights Reserved.

include_recipe "stegosoc::wazuh_repo"

opsworks_app_stegosoc = search('aws_opsworks_app','name:stegosoc').first

node.override['stegosoc']['wazuh-manager']['ip'] = opsworks_app_stegosoc['environment']['hound_ip']

case node['platform_family']
when 'debian'

    package "wazuh-agent" do
        options '--force-yes'
        action :install
    end

when 'rhel'
    package "wazuh-agent" do
        options '-y'
        action :install
    end
end

template "/var/ossec/etc/ossec.conf" do
    source "wazuh/ossec.conf.erb"
    owner "root"
    group "root"
    action :create
    variables({
        :manager_ip => node['stegosoc']['wazuh-manager']['ip'],
        :syscheck_frequency => node['stegosoc']['coon']['syscheck_frequency']
        })
end

bash "coon_registration" do
    user 'root'
    code "/var/ossec/bin/agent-auth -m #{node['stegosoc']['wazuh-manager']['ip']} -p #{node['stegosoc']['wazuh-manager']['port']} -A #{node['stegosoc']['coon']['agent_unique_name']}"
    ignore_failure true
    timeout 90
    action :run
end

service "ossec-control" do
    start_command "/var/ossec/bin/ossec-control start"
    restart_command "/var/ossec/bin/ossec-control restart"
    action :restart
end

%w(clamav clamav-daemon).each do |pkg|
    package pkg do
        action :install
    end
end

service "clamav-freshclam" do
    action [:restart]
end


#Install SSM Agent

include_recipe 'ssm_agent::default'
