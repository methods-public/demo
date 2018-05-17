#
# Cookbook Name:: sda-agent
# Attributes:: default
#
# Copyright 2014, Serena Software
#
# Apache License, Version 2.0
#

default['sda-agent']['server_uri'] = "http://localhost:8080/serena_ra"
default['sda-agent']['agent_name'] = node['fqdn']
default['sda-agent']['remote_host'] =  "localhost"
default['sda-agent']['remote_port'] = 7918
default['sda-agent']['proxy_host'] = ""
default['sda-agent']['proxy_port'] = 20080
default['sda-agent']['mutual_auth'] = false
default['sda-agent']['reinstall'] = false
	
case node['platform']
when 'windows'
	default['sda-agent']['agent_dir'] = 'C:\Program Files\Serena\SDA Agent'
	default['sda-agent']['java_home'] = 'C:\Program Files\Java\jre7'
	default['sda-agent']['user'] = "#{node['hostname']}\sda"
	default['sda-agent']['password'] = '$1$ZKjYOOUo$GdCCkWL73olgpCUHUjVz40' #sda
	default['sda-agent']['group'] = 'Users'
else
	default['sda-agent']['agent_dir'] = '/opt/serena_da/agent'
	default['sda-agent']['java_home'] = '/usr/lib/jvm/java-6-openjdk-amd64'
	default['sda-agent']['user'] = 'sda'
	default['sda-agent']['password'] = '$1$ZKjYOOUo$GdCCkWL73olgpCUHUjVz40' #sda
	default['sda-agent']['uid'] = 10001
	default['sda-agent']['group'] = 'sda'
	default['sda-agent']['gid'] = 10001
	default['sda-agent']['shell'] = '/bin/bash'
end

