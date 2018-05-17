#
# Cookbook Name:: oracle_client
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

directory node['oracle_client']['temp_dir'] do
action :create
end

remote_file "#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}#{node['oracle_client']['zip']}" do
source "#{node['oracle_client']['source']}/#{node['oracle_client']['output_file']}#{node['oracle_client']['zip']}"
action :create
not_if {::File.exists?("#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}#{node['oracle_client']['zip']}")}
end

powershell_script "Unzip the oracle file" do
	code <<-EOH
	Add-Type -AssemblyName System.IO.Compression.FileSystem
	function Unzip
	{
    	param([string]$zipfile, [string]$outpath)
	[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
	}
	Unzip "#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}#{node['oracle_client']['zip']}" "#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}"
	EOH
not_if {::File.exists?("#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}")}
end

template "#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}\\#{node['oracle_client']['client']}\\#{node['oracle_client']['response_dir']}\\#{node['oracle_client']['response_file']}" do
source "client_install.erb"
variables({
        :oracle_install_response_file_version => node['oracle_client']['oracle_install_response_file_version'],
	:oracle_hostname => node['oracle_client']['oracle_hostname'],
	:unix_group_name => node['oracle_client']['unix_group_name'],
	:inventory_location => node['oracle_client']['inventory_location'],
	:selected_language => node['oracle_client']['selected_language'],
	:oracle_home => node['oracle_client']['oracle_home'],
	:oracle_base => node['oracle_client']['oracle_base'],
	:oracle_install_client_install_type => node['oracle_client']['oracle_install_client_install_type'],
	:oracle_install_client_port_number => node['oracle_client']['oracle_install_client_port_number'],
	:oracle_install_client_scheduler_agent_hostname => node['oracle_client']['oracle_install_client_scheduler_agent_hostname'],
	:oracle_install_client_scheduler_agent_port_number => node['oracle_client']['oracle_install_client_scheduler_agent_port_number']

})
only_if {::File.exists?("#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}")}
end

include_recipe "oracle_client::install"
