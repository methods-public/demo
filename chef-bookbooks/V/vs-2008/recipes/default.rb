#
# Author:: Joe Fitzgerald (<joe.fitzgerald@emc.com>)
# Cookbook Name:: vs-2008
# Recipe:: default
#
# Copyright 2012, EMC Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, VS2008::Prerequisites)

#Verify if visual Studio  is installed
vs2008_is_installed = is_vs2008_installed?()
Chef::Log.info("Starting Visual Studio 2008 installation.")
Chef::Log.info("Visual Studio 2008 is already installed!!! Skipping the installation.") if vs2008_is_installed

# Validate That ISOs Are Available In Specified Locations
# Unzip VS 2008 ISO To Staging Folder
# Ensure the installation ISO path has been set by the user other the install will not procede
if !node['vs-2008']['base-network-location'] 
  raise 'visual studio source attribute must be set before running this cookbook'
end


### Visual Studio 2008 install SQL Server 2005 which isn't support on Windows 8.1/2012 R2 or newer OS. This suppresses the popup and installs it.
registry_key node['vs-2008']['sql-server-appcompat']['path'] do
  values [{:name => node['vs-2008']['sql-server-appcompat']['key'] , :type => node['vs-2008']['sql-server-appcompat']['key-type'], :data => node['vs-2008']['sql-server-appcompat']['value'] }        
         ]
  action :create
end

vs2008_extraction_path = win_friendly_path(node['vs-2008']['base-extraction-path'])


# Extracting the ISO image
seven_zip_archive 'extracting_visual_studio_iso' do
  path vs2008_extraction_path
  source node['vs-2008']['base-iso-location']
  overwrite true
  checksum node['vs-2008']['base-iso-checksum']
  not_if { vs2008_is_installed }
end


# Install VS 2008
vs2008setup = File.join(node['vs-2008']['base-extraction-path'], 'setup\setup.exe').gsub("/", "\\")
Chef::Log.info("Installing Visual Studio 2008: #{vs2008setup}")  unless vs2008_is_installed
Chef::Log.info("install options ")  unless vs2008_is_installed

Chef::Log.info("vs2008_is_installed is #{vs2008_is_installed}")

windows_package "#{node['vs-2008']['base-display-name']}" do
  source "#{vs2008setup}"
  options node['vs-2008']['install-options']
  timeout node['vs-2008']['timeout']
  installer_type :custom
  notifies :delete, "file[#{node['vs-2008']['base-iso-cache-location']}]", :immediately
  notifies :delete, "directory[#{vs2008_extraction_path}]", :immediately
  not_if { vs2008_is_installed }
end


vs2008_sp1_is_installed = is_vs2008_sp1_version_installed?()
Chef::Log.info("Installing Visual Studio 2008 SP1.") 
Chef::Log.info("Visual Studio 2008 SP1 is already installed!!! Skipping the installation.") if vs2008_sp1_is_installed


vs2008_sp1_extraction_path = node['vs-2008']['sp1-extraction-path'].gsub("/", "\\")
vs2008_sp1_iso_location = node['vs-2008']['sp1-iso-location']
 
## Extracting the SP1 ISO image
seven_zip_archive 'extracting_visual_studio_sp1_iso' do
  path vs2008_sp1_extraction_path
  source vs2008_sp1_iso_location
  overwrite true
  checksum node['vs-2008']['sp1-iso-checksum']
  not_if {vs2008_sp1_is_installed}
 end


# Install VS 2008 SP1
vs2008sp1setup = File.join(node['vs-2008']['sp1-extraction-path'], node['vs-2008']['sp1-installer']).gsub("/", "\\")
vs2008sp1installopt = "#{node['vs-2008']['sp1-install-options']} /log #{node['vs-2008']['sp1-install-log']}"


Chef::Log.info("Running #{vs2008sp1setup} #{vs2008sp1installopt}")
windows_package "#{node['vs-2008']['sp1-display-name']}" do
  source "#{vs2008sp1setup}"
  options vs2008sp1installopt
  timeout node['vs-2008']['timeout']
  installer_type :custom
  action :install
  notifies :delete, "directory[#{vs2008_sp1_extraction_path}]", :immediately
  notifies :delete, "file[#{node['vs-2008']['sp1-iso-cache-location']}]", :immediately
  not_if { vs2008_sp1_is_installed }
#  notifies :request, 'windows_reboot[60]'
end

# Deleting the RTM ISO file from temp folder
file "#{node['vs-2008']['base-iso-cache-location']}" do
  action :nothing
  backup false
  not_if {node['vs-2008']['preserve_iso_file']}
end

# Deleting the SP1 ISO file from temp folder
file "#{node['vs-2008']['sp1-iso-cache-location']}" do
  action :nothing
  backup false
  not_if {node['vs-2008']['preserve_iso_file']}
end


# Cleanup extracted RTM files and directories
directory vs2008_extraction_path do
  action :nothing
  recursive true
  not_if {node['vs-2008']['preserve_extracted_file']}
end

# Cleanup extracted SP1 files and directories
directory vs2008_sp1_extraction_path do
  action :nothing
  recursive true
  not_if {node['vs-2008']['preserve_extracted_file']}
end
