#
# Cookbook Name:: sda-agent
# Recipe:: agent_linux
#
# Copyright 2014, Serena Software
#
# Apache License, Version 2.0
#

src_uri = "#{node['sda-agent']['server_uri']}/rest/agent/upgradeJar"
downloaded_jar = "#{Chef::Config['file_cache_path']}/air-agentupgrade.jar"
extracted_dir = "#{Chef::Config['file_cache_path']}/agent-upgrade"
install_properties = "#{Chef::Config['file_cache_path']}/agent.install.properties"
startup_script = "#{node['sda-agent']['agent_dir']}/bin/sraagent"

# Create SDA group
group node['sda-agent']['group'] do
	gid node['sda-agent']['gid']
	append true
end

# Create SDA user
user node['sda-agent']['user'] do
	supports :manage_home => true
	comment 'SDA Agent User'
	uid node['sda-agent']['uid']
	gid node['sda-agent']['gid']
	home "/home/#{node['sda-agent']['user']}"
	shell node['sda-agent']['shell']
	password node['sda-agent']['password']
end

# Create Agent home directory
directory node['sda-agent']['agent_dir'] do
	owner node['sda-agent']['user']
	group node['sda-agent']['group']
	mode '0755'
	action :create
	recursive true
end

# Download Agent installer
this_installer_file = remote_file "agent_download" do
	path downloaded_jar
	source src_uri
	mode '0644'
	use_last_modified true
	use_conditional_get true
end

# Delete extract directory if it exists
directory "cleanup_agent" do
	path extracted_dir
	recursive true
	action :delete 
	only_if { this_installer_file.updated_by_last_action? && ::File.exists?(extracted_dir) }
end

# Extract installer
execute "extract_agent" do
	user node['sda-agent']['admin_user']
	cwd Chef::Config['file_cache_path']
	command "#{node['sda-agent']['java_home']}/bin/jar -xf ./air-agentupgrade.jar"
	only_if { this_installer_file.updated_by_last_action? || !::File.exists?(extracted_dir) } 
end

# Create Agent installer property file
this_property_file = template "agent-install.properties" do
	path install_properties
	source "agent.install.properties.erb"
	mode '0644'
	only_if { this_installer_file.updated_by_last_action? || node['sda-agent']['reinstall'] }
	notifies :stop, "service[sdaagent]", :immediately
	notifies :run, "execute[install_agent]", :immediately
	notifies :run, "execute[chown_dir]", :immediately
	notifies :stop, "service[sdaagent]"
end

# Install Agent using property file
this_installer_run = execute "install_agent" do
	action :nothing
	environment(
	'JAVA_HOME' => node['sda-agent']['java_home']
	)
	cwd extracted_dir
	command "#{node['sda-agent']['shell']} ./install-agent-from-file.sh ../agent.install.properties"
end 

# Set permissions of install directory
execute "chown_dir" do
	action :nothing
	command "chown -R #{node['sda-agent']['user']}:#{node['sda-agent']['user']} #{node['sda-agent']['agent_dir']}"
end

# Create service
this_service_file = template "sdaagent" do
	path "/etc/init.d/sdaagent"
	owner "root"
	group "root"
	source "sdaagent.erb"
	mode '0755'
	notifies :start, "service[sdaagent]"
	only_if { this_installer_file.updated_by_last_action? || node['sda-agent']['reinstall'] }
end


# Provide SDA Service
service "sdaagent" do
  action :nothing
  supports :restart => true, :start => true, :stop => true, :status => true
end