#
# Cookbook Name:: sda-agent
# Recipe:: default
#
# Copyright 2014, Serena Software
#
# Apache License, Version 2.0
#

case node['platform']
when 'windows'
	include_recipe "sda-agent::agent_windows"
else
	include_recipe "sda-agent::agent_linux"
end
