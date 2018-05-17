#
# Cookbook Name:: tomcat_config
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "tomcat_install::default"

template "#{node['tomcat_install']['user_dir']}/#{node['tomcat_install']['local']}/#{node['tomcat_install']['tomcat_dir']}/conf/#{node['tomcat_install']['catalina_file']}" do
        source "catalina.erb"
        variables({
                :catalina_properties => node['tomcat_install']['catalina_properties']
        })
        owner 'root'
        group 'root'
        mode '0755'
        only_if {::File.exists?( "#{node['tomcat_install']['user_dir']}/#{node['tomcat_install']['local']}/#{node['tomcat_install']['tomcat_dir']}/conf/")}
end

directory "#{node['tomcat_install']['user_dir']}/#{node['tomcat_install']['local']}/#{node['tomcat_install']['tomcat_dir']}/#{node['tomcat_install']['shared']}" do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

directory "#{node['tomcat_install']['user_dir']}/#{node['tomcat_install']['local']}/#{node['tomcat_install']['tomcat_dir']}/#{node['tomcat_install']['shared']}/#{node['tomcat_install']['classes']}" do
        owner 'root'
        group 'root'
        mode '0755'
        action :create
end

file "#{node['tomcat_install']['user_dir']}/#{node['tomcat_install']['local']}/#{node['tomcat_install']['tomcat_dir']}/#{node['tomcat_install']['shared']}/#{node['tomcat_install']['classes']}/#{node['tomcat_install']['shared_file']}" do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

passwords = Chef::EncryptedDataBagItem.load("data_bag_name", "context-user")

template "#{node['tomcat_install']['user_dir']}/#{node['tomcat_install']['local']}/#{node['tomcat_install']['tomcat_dir']}/conf/#{node['tomcat_install']['context']}" do
        source "context.erb"
        variables({
                :context_username => passwords['context_username'],
		:context_password => passwords['context_password']
        })
        owner 'root'
        group 'root'
        mode '0755'
        only_if {::File.exists?( "#{node['tomcat_install']['user_dir']}/#{node['tomcat_install']['local']}/#{node['tomcat_install']['tomcat_dir']}/conf/")}
end
