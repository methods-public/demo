#
# Cookbook Name:: coopr
# Recipe:: config
#
# Copyright © 2013-2014 Cask Data, Inc.
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

coopr_conf_dir = "/etc/coopr/#{node['coopr']['conf_dir']}"

directory coopr_conf_dir do
  mode '0755'
  owner 'root'
  group 'root'
  action :create
  recursive true
end

# Setup coopr-site.xml provisioner-site.xml
%w(coopr_site provisioner_site).each do |sitefile|
  next unless node['coopr'].key?(sitefile)
  my_vars = { :options => node['coopr'][sitefile] }

  template "#{coopr_conf_dir}/#{sitefile.tr('_', '-')}.xml" do
    source 'generic-site.xml.erb'
    mode '0644'
    owner 'root'
    group 'root'
    action :create
    variables my_vars
  end
end # End coopr-site.xml provisioner-site.xml

# Setup coopr-security.xml
if node['coopr'].key?('coopr_security')
  my_vars = { :options => node['coopr']['coopr_security'] }

  template "#{coopr_conf_dir}/coopr-security.xml" do
    source 'generic-site.xml.erb'
    mode '0600'
    owner node['coopr']['user']
    group node['coopr']['group']
    variables my_vars
    action :create
  end
end # End coopr-security.xml

# Update alternatives to point to our configuration
execute 'update coopr-conf alternatives' do
  command "update-alternatives --install /etc/coopr/conf coopr-conf /etc/coopr/#{node['coopr']['conf_dir']} 50"
  not_if "update-alternatives --display coopr-conf | grep best | awk '{print $5}' | grep /etc/coopr/#{node['coopr']['conf_dir']}"
end
