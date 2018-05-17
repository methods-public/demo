# Encoding: utf-8
#
# Cookbook Name:: dtach
# Recipe:: default
#
# Copyright 2014, Ross Timson
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

packages = %w{ gcc autoconf make }

packages.each do |name|
  package name
end

tar_name = "dtach-#{node['dtach']['version']}"
remote_file 'dtach' do
  path "#{Chef::Config['file_cache_path']}/#{tar_name}.tar.gz"
  source "http://downloads.sourceforge.net/project/dtach/dtach/#{node['dtach']['version']}/#{tar_name}.tar.gz" # rubocop:disable LineLength
  checksum node['dtach']['checksum']
  notifies :run, 'bash[install_dtach]', :immediately
end

bash 'install_dtach' do
  user 'root'
  cwd Chef::Config['file_cache_path']
  code <<-EOH
      tar -zxf #{tar_name}.tar.gz
      cd #{tar_name}
      ./configure
      make
      mv dtach #{node['dtach']['install_path']}
    EOH
  action :nothing
end
