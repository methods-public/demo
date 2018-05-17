#
# Cookbook Name:: thruk
# Recipe:: default
#
# Copyright 2013, Tech Financials
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

begin
  include_recipe "thruk::#{node['platform_family']}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Log.warn "A thruk recipe does not exist for the platform_family: #{node['platform_family']}"
end

# force apache to use prefork mode - event requires recompiling php
node.set['apache']['mpm'] = 'prefork' if node['apache']['mpm'] == 'event'

include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_fcgid'
include_recipe 'apache2::mod_ssl' if node['thruk']['use_ssl']

if node['platform'] == 'centos' && node['apache']['version'] == '2.4'
  apache_module 'unixd' do
    enable false
  end
  link "#{node['apache']['dir']}/mods-enabled/0unixd.load" do
    to "#{node['apache']['dir']}/mods-available/unixd.load"
    notifies :reload, 'service[apache2]', :delayed
  end
end

apache_site '000-default' do
  enable false
end

apache_config 'thruk' do
  enable false
end

apache_config 'thruk_cookie_auth_vhost' do
  enable false
end

remote_directory "#{node['thruk']['docroot']}/icons" do
  cookbook node['thruk']['icon_cookbook']
  mode '0755'
end

template "#{node['thruk']['conf_dir']}/thruk_local.conf" do
  mode '0644'
end

file "#{node['apache']['dir']}/conf.d/thruk.conf" do
  action :delete
  notifies :reload, 'service[apache2]', :delayed
end

directory "#{node['thruk']['conf_dir']}/plugins/plugins-enabled"

node['thruk']['plugins'].each do |plugin|
  link "#{node['thruk']['conf_dir']}/plugins/plugins-enabled/#{plugin}" do
    to "#{node['thruk']['conf_dir']}/plugins/plugins-available/#{plugin}"
    notifies :restart, 'service[thruk]', :delayed
  end
end

if node['thruk']['use_ssl']
  cookbook_file "#{node['apache']['dir']}/ssl/#{node['thruk']['cert_name']}.crt" do
    cookbook node['thruk']['cert_cookbook']
    source "certs/#{node['thruk']['cert_name']}.crt"
    mode '0644'
    notifies :restart, 'service[apache2]'
  end

  cookbook_file "#{node['apache']['dir']}/ssl/#{node['thruk']['cert_name']}.key" do
    cookbook node['thruk']['cert_cookbook']
    source "certs/#{node['thruk']['cert_name']}.key"
    mode '0600'
    notifies :restart, 'service[apache2]'
  end

  cookbook_file "#{node['apache']['dir']}/ssl/#{node['thruk']['cert_ca_name']}.crt" do
    cookbook node['thruk']['cert_cookbook']
    source "certs/#{node['thruk']['cert_ca_name']}.crt"
    mode '0644'
    not_if { node['thruk']['cert_ca_name'].nil? }
    notifies :restart, 'service[apache2]'
  end

  template '/etc/default/thruk' do
    source 'thruk-default.erb'
    mode '0644'
  end

end

template "#{node['apache']['dir']}/sites-available/thruk.conf" do
  source 'thruk-apache2.conf.erb'
  mode '0644'
  if ::File.symlink?("#{node['apache']['dir']}/sites-enabled/thruk.conf")
    notifies :reload, 'service[apache2]', :delayed
  end
end

template "#{node['thruk']['conf_dir']}/cgi.cfg" do
  mode '0644'
end

# we need apache to restart before thruk service starts
execute 'a2ensite thruk.conf' do
  command '/usr/sbin/a2ensite thruk.conf'
  notifies :restart, 'service[apache2]', :immediately
  not_if { ::File.symlink?("#{node['apache']['dir']}/sites-enabled/thruk.conf") }
  only_if { ::File.exist?("#{node['apache']['dir']}/sites-available/thruk.conf") }
end

service 'thruk' do
  action [:enable, :start]
  supports [:restart, :status]
  ignore_failure true
  subscribes :restart, "template[#{node['thruk']['conf_dir']}/thruk_local.conf]"
  subscribes :restart, 'template[/etc/default/thruk]' if node['thruk']['use_ssl']
  subscribes :restart, 'service[apache2]', :delayed
end
