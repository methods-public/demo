#
# Cookbook Name:: dbforbix
# Recipe:: default
#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Author:: Tiago Cruz (tiago.cruz@movile.com)
#
# Copyright:: 2017-2018, Movile
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

user 'dbforbix' do
  system true
end

directory node['dbforbix']['dir'] do
  owner 'dbforbix'
  group 'dbforbix'
  mode 0755
end

# Installation and unarchive
case node['dbforbix']['install_method']
when 'git'

  package 'git'
  
  git node['dbforbix']['dir'] do
    action :sync
    user 'dbforbix'
    repository node['dbforbix']['url_git']
    revision 'master'
    # install only or keep upgrading?
    if node['dbforbix']['install_only']
      not_if { ::File.directory?("#{node['dbforbix']['dir']}/dist") }
    end
  end
  
when 'archive'

  # supported archive types
  if node['dbforbix']['url_archive'] =~ /\.zip$/
    package 'unzip'

    remote_file "#{Chef::Config[:file_cache_path]}/dbforbix3.zip" do
      owner 'root'
      group 'root'
      mode 0644
      source node['dbforbix']['url_archive']
      notifies :run, 'execute[unzip dbforbix3]', :immediately
      # install only or keep upgrading?
      if node['dbforbix']['install_only']
        not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/dbforbix3.zip") }
      end
    end

    execute 'unzip dbforbix3' do
      action :nothing
      user 'dbforbix'
      command "unzip -d #{node['dbforbix']['dir']} #{Chef::Config[:file_cache_path]}/dbforbix3.zip"
    end

  elsif node['dbforbix']['url_archive'] =~ /\.tar\.gz$/
    remote_file "#{Chef::Config[:file_cache_path]}/dbforbix3.tar.gz" do
      owner 'root'
      group 'root'
      mode 0644
      source node['dbforbix']['url_archive']
      notifies :run, 'execute[untar dbforbix3]', :immediately
      # install only or keep upgrading?
      if node['dbforbix']['install_only']
        not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/dbforbix3.tar.gz") }
      end
    end

    execute 'untar dbforbix3' do
      action :nothing
      user 'dbforbix'
      command "tar -C #{node['dbforbix']['dir']} -zxf #{Chef::Config[:file_cache_path]}/dbforbix3.tar.gz"
    end
  else
    raise 'Unsupported archive type for installation. Please use .zip or .tar.gz'
  end

end

# configuration
file node['dbforbix']['log_file'] do
  owner 'dbforbix'
  group 'dbforbix'
  mode 0644
end

template "#{node['dbforbix']['dir']}/dist/log4j.properties" do
  owner 'dbforbix'
  group 'dbforbix'
  mode 0644
  source 'log4j.properties.erb'
end

template "#{node['dbforbix']['dir']}/dist/conf/config.properties" do
  owner 'dbforbix'
  group 'dbforbix'
  mode 0640
  source 'config.properties.erb'
  variables(
    :zabbix => node['dbforbix']['zabbix'],
    :databases => node['dbforbix']['databases']
  )
end

# service
systemd_service 'dbforbix' do
  unit_description 'DBforBIX Monitoring Agent'
  unit_after 'network.target'
  service_user 'dbforbix'
  service_group 'dbforbix'

  install do
    wanted_by 'multi-user.target'
  end

  service do
    working_directory "#{node['dbforbix']['dir']}/dist"
    exec_start "#{node['dbforbix']['java_exec']} -jar dbforbix_run.jar -b #{node['dbforbix']['dir']}/dist -a start"
  end
end

service 'dbforbix' do
  action [ :enable, :start ]
end
