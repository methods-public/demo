#
# Author:: James Le Cuirot <james.le-cuirot@yakara.com>
# Cookbook Name:: xenserver-tools
# Recipe:: default
#
# Copyright (C) 2016 Yakara Ltd
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

version = '7.0.0-24'
machine = node['kernel']['machine']
machine = 'i386' if machine == 'i686'

case node['platform_family']
when 'debian'
  provider = :dpkg_package
  files = [
    "xe-guest-utilities_#{version}_all.deb"
  ]
when 'rhel'
  provider = :package
  files = [
    "xe-guest-utilities-#{version}.#{machine}.rpm",
    "xe-guest-utilities-xenstore-#{version}.#{machine}.rpm"
  ]
end

files.map do |file|
  path = "#{Chef::Config[:file_cache_path]}/#{file}"

  cookbook_file path do
    source file
    owner 'root'
    group node['root_group']
    mode '0644'
  end

  send provider, file do
    source path
  end
end

systemd_service 'xe-linux-distribution' do
  description 'Linux Guest Agent'
  notifies :restart, 'service[xe-linux-distribution]'

  service do
    exec_start_pre \
      '/usr/sbin/xe-linux-distribution /var/cache/xe-linux-distribution'
    exec_start \
      '/usr/sbin/xe-daemon'
  end

  install do
    wanted_by 'multi-user.target'
  end
end

service 'xe-linux-distribution' do
  action [:enable, :start]
end
