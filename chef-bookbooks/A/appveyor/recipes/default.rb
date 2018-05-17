#
# Cookbook Name:: appveyor
# Recipe:: default
#
# Copyright (C) 2015 Brafton Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "windows"

windows_package 'AppveyorDeploymentAgent' do
	source node['appveyor']['agent']['source']
	installer_type :msi
	options "/quiet /qn /norestart /log install.log ENVIRONMENT_ACCESS_KEY=#{node['appveyor']['agent']['access_key']}"
	not_if File.exists?(node['appveyor']['agent']['location'])
end

unless node['appveyor']['agent']['deployment_group'].nil?
	registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\AppVeyor\\DeploymentAgent' do
		values [{
			:name => "DeploymentGroup",
			:type => :string,
			:data => node['appveyor']['agent']['deployment_group']
		}]
		action :create
	end

	service 'Appveyor.DeploymentAgent' do
		action :restart
	end
end
