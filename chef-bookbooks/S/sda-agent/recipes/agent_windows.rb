#
# Cookbook Name:: sda-agent
# Recipe:: agent_windows.rb
#
# Copyright 2014, Serena Software
#
# Apache License, Version 2.0
#

src_uri = "#{node['sda-agent']['server_uri']}/rest/agent/upgradeJar"
downloaded_jar = "#{Chef::Config['file_cache_path']}\air-agentupgrade.jar"
extracted_dir = "#{Chef::Config['file_cache_path']}\agent-upgrade"
install_properties = "#{Chef::Config['file_cache_path']}\agent.install.properties"
startup_script = "#{node['sda-agent']['agent_dir']}\bin\sraagent.bat"

# Start Agent
#execute "start_agent" do
#  environment(
#	'JAVA_HOME' => node['sda-agent']['java_home']
#  )	
#  cwd node['sda-agent']['agent_dir']
#  user node['sda-agent']['user']
#  group node['sda-agent']['group']
#  command "#{node['sda-agent']['agent_dir']}/bin/sraagent start"
#end

