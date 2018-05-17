#
# Cookbook Name:: cdap
# Recipe:: master
#
# Copyright © 2013-2017 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'cdap::default'

# All supported release versions support HBase 0.96 and 0.98
pkgs = ['cdap-hbase-compat-0.96', 'cdap-hbase-compat-0.98']
pkgs += ['cdap-hbase-compat-1.0', 'cdap-hbase-compat-1.0-cdh'] if node['cdap']['version'].to_f >= 3.1
pkgs += ['cdap-hbase-compat-1.1'] if node['cdap']['version'].to_f >= 3.2
pkgs += ['cdap-hbase-compat-1.0-cdh5.5.0'] if node['cdap']['version'].to_f >= 3.3
pkgs += ['cdap-hbase-compat-1.2-cdh5.7.0'] if node['cdap']['version'].to_f >= 3.4
pkgs += ['cdap-hbase-compat-0.94'] if node['cdap']['version'].to_f < 3.1

pkgs.each do |pkg|
  package pkg do
    version node['cdap']['version']
    action :install
  end
end

package 'cdap-master' do
  action :install
  version node['cdap']['version']
end

# Include kerberos support
if hadoop_kerberos?

  if node['cdap'].key?('kerberos') && node['cdap']['kerberos'].key?('cdap_keytab') &&
     node['cdap']['kerberos'].key?('cdap_principal') &&
     cdap_property?('kerberos.auth.enabled').to_s == 'true'

    directory '/etc/default' do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end

    template '/etc/default/cdap-master' do
      source 'generic-env.sh.erb'
      mode '0755'
      owner 'root'
      group 'root'
      action :create
      variables options: node['cdap']['kerberos']
    end # End /etc/default/cdap-master

    group 'hadoop' do
      append true
      members ['cdap']
      action :modify
    end
  else
    # Hadoop is secure, but we're not configured for Kerberos
    log 'bad-kerberos-configuration' do
      message "Invalid Kerberos configuration: You must specify node['cdap']['cdap_site']['kerberos.auth.enabled']"
      level :error
    end
    Chef::Application.fatal!('Invalid Hadoop/CDAP kerberos configuration')
  end
end

template '/etc/init.d/cdap-master' do
  source 'cdap-service.erb'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
  variables node['cdap']['master']
end

service 'cdap-master' do
  status_command 'service cdap-master status'
  action node['cdap']['master']['init_actions']
end

# CDAP Upgrade Tool
execute 'cdap-upgrade-tool' do
  command "#{node['cdap']['master']['init_cmd']} run co.cask.cdap.data.tools.UpgradeTool upgrade force"
  action :nothing
  user node['cdap']['master']['user']
end
