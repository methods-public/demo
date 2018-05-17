#
# Cookbook Name:: thruk
# Recipe:: debian
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

if node['thruk']['version'].split('.')[0].to_i < 2
  node['thruk']['packages'].each do |pkg|
    package pkg
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{node['thruk']['pkg_name']}" do
    action :create_if_missing
    source "#{node['thruk']['pkg_url']}/#{node['thruk']['pkg_name']}"
    mode '0644'
    backup false
    not_if "dpkg-query -W thruk | grep -q '^thruk[[:blank:]]#{node['thruk']['version']}$'"
    notifies :install, 'dpkg_package[thruk]', :immediately
  end

  dpkg_package 'thruk' do
    source "#{Chef::Config[:file_cache_path]}/#{node['thruk']['pkg_name']}"
    action :nothing
  end

  file 'thruk-cleanup' do
    path "#{Chef::Config[:file_cache_path]}/#{node['thruk']['pkg_name']}"
    action :delete
  end
else
  include_recipe 'apt'

  apt_repository 'labs-thruk' do
    uri          "http://labs.consol.de/repo/stable/#{node['platform']}"
    key          'F8C1CA08A57B9ED7'
    keyserver    'hkp://keys.gnupg.net'
    distribution node['lsb']['codename']
    components   ['main']
  end

  package 'thruk'
end
