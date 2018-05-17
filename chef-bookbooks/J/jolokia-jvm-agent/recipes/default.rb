#
# Cookbook hirocaster:: jolokia-jvm-agent
# Recipe:: default
#
# Copyright 2015, hirocaster
#
# All rights reserved - Do Not Redistribute
#

install_dir = node['jolokia-jvm-agent']['dir']

directory install_dir do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

version = node['jolokia-jvm-agent']['version']

remote_file "#{install_dir}/jolokia-jvm-#{version}-agent.jar" do
  source "https://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/#{version}/jolokia-jvm-#{version}-agent.jar"
  owner 'root'
  group 'root'
  mode '0644'
end

link "#{install_dir}/jolokia-jvm-agent.jar" do
  to "#{install_dir}/jolokia-jvm-#{version}-agent.jar"
end
