#
# Cookbook Name:: AWS_ms_dotnet
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

::Chef::Recipe.send(:include, AWSToolsAndSDKForNetSdk::Helper)


if is_aws_version_installed?() 
  Chef::Log.warn("AWS Tools And SDK For Net SDK version #{node['AWS_ms_dotnet']['version']} is already installed.")
  return
end

Chef::Log.info("Installing AWS Tools And SDK For Net SDK version #{node['AWS_ms_dotnet']['version']} for Windows...")


windows_package "AWSPSTools" do
  source node['AWS_ms_dotnet']['source']
  installer_type :msi
  options node['AWS_ms_dotnet']['install_options']
  checksum node['AWS_ms_dotnet']['checksum']
  action :install
end

