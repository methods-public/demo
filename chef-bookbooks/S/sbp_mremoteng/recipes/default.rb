#
# Cookbook Name:: sbp_mremoteng
# Recipe:: default
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

windows_package node['mremoteng']['package_name'] do
  source node['mremoteng']['url']
  checksum node['mremoteng']['checksum']
  options "APPLICATIONROOTDIRECTORY=\"#{node['mremoteng']['install_dir']}\""
  version node['mremoteng']['version']
  installer_type :msi
  action :install
end

unless node['mremoteng']['shared_config_dir'].nil?
  hosts = partial_search(:node, 
                         "name:*",
                         :keys => { 
                           'hostname' => ['hostname'],
                           'name' => ['name'],
                           'os' => ['os'],
                           'domain' => ['domain'],
                           'chef_environment' => ['chef_environment'],
                           'ipaddress' => ['ipaddress']
                           })
  hosts = hosts.sort_by { |host| host['hostname'].to_s }
  environments = Hash.new
  hosts.each do |host|
    environments[host['chef_environment']] = [] if environments[host['chef_environment']].nil? 
    environments[host['chef_environment']] << host unless host['hostname'].to_s == '' 
  end

  directory node['mremoteng']['shared_config_dir'] do
    recursive true
  end

  template "#{node['mremoteng']['shared_config_dir']}\\confCons.xml" do
    source 'confCons.xml.erb'
    variables(
      :recipe_file => (__FILE__).to_s.split("cookbooks/").last,
      :template_file => source.to_s,
      :environments => environments
    )
  end

  template "#{node['mremoteng']['install_dir']}\\mRemoteNG.exe.config" do
    source "mRemoteNG.exe.config-#{node['mremoteng']['version']}.erb"
    variables(
      :recipe_file => (__FILE__).to_s.split("cookbooks/").last,
      :template_file => source.to_s,
      :shared_config_dir => node['mremoteng']['shared_config_dir']
    )
  end
end

