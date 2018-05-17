#
# Cookbook Name:: nagios-grid
# Recipe:: nagios-nrpe-server
#
# Copyright 2016, whitestar
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

platform = node['platform']
platform_version = node['platform_version']

pkgs = [
  'nagios-nrpe-server',
  'nagios-plugins',
  'nagios-plugins-contrib',  # for check_memory
]

if (platform == 'debian' && platform_version < '9.0') \
  || (platform == 'ubuntu' && platform_version < '17.04')
  pkgs += ['libnagios-plugin-perl']  # for check_memory
end

pkgs.each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

pkg = 'smartmontools'
act = (node['nagios']['nrpe']['with_smartmontools'] ? :install : :remove)
resources(package: pkg) rescue package pkg do
  action act
end

[
  'nagios-nrpe-server',
].each {|nagios_service|
  service nagios_service do
    action [:enable, :start]
    supports status: true, restart: true, reload: true
  end
}

template '/etc/nagios/nrpe_local.cfg' do
  source  'etc/nagios/nrpe_local.cfg'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nagios-nrpe-server]'
end

[
  'check_logs.pl',
  'check_mem.pl',
  'check_smart.pl',
].each {|cmd|
  template "/usr/lib/nagios/plugins/#{cmd}" do
    source  "usr/lib/nagios/plugins/#{cmd}"
    owner 'root'
    group 'root'
    mode '0755'
  end
}

directory '/etc/nagios/check_logs' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/nagios/check_logs/check_logs.cfg' do
  source  'etc/nagios/check_logs/check_logs.cfg'
  owner 'root'
  group 'root'
  mode '0644'
end
