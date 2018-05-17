#
# Cookbook Name:: alphard-chef-artifactory
# Recipe:: default
#
# Copyright 2016, Hydra Technologies, Inc
#
# All rights reserved - Do Not Redistribute
#

artifactory = node['alphard']['artifactory']
user = artifactory['user']
group = artifactory['group']
home = artifactory['home']
version = artifactory['version']
archive_url = "https://bintray.com/jfrog/artifactory/download_file?file_path=jfrog-artifactory-oss-#{version}.zip"
archive_directory = "#{Chef::Config['file_cache_path']}/artifactory"
archive_file = "#{archive_directory}/#{version}.zip"
configuration_template_file = artifactory['configuration_template_file']
configuration_file = "#{home}/etc/artifactory.config.xml"

include_recipe 'java'

directory archive_directory do
  owner user
  group group
  mode '0755'
  recursive true
  action :create
end

remote_file archive_file do
  source archive_url
  owner user
  group group
  mode '0755'
  action :create_if_missing
end

unless File.exist?(home)
  directory home do
    owner user
    group group
    mode '0755'
    recursive true
    action :create
  end
end

package 'zip'

execute 'unzip artifactory' do
  command <<-EOH
    unzip #{archive_file} -d #{archive_directory}
    mv #{archive_directory}/artifactory-oss-#{version}/* #{home}
  EOH
  not_if "[ -f #{home}/bin/artifactoryctl ]"
end

template configuration_file do
  source configuration_template_file
  owner user
  group group
  mode '0644'
  not_if '[ -f /etc/init.d/artifactory ]'
end

execute 'install artifactory' do
  command "#{home}/bin/installService.sh"
  not_if '[ -f /etc/init.d/artifactory ]'
end

service 'artifactory' do
  supports restart: true
  action :restart
end
