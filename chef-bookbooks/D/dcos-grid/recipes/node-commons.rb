#
# Cookbook Name:: dcos-grid
# Recipe:: node-commons
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

# https://dcos.io/docs/1.8/administration/installing/custom/system-requirements/

genconf_dir = node['dcos-grid']['bootstrap']['genconf_dir']

resources(directory: genconf_dir) rescue directory genconf_dir do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template "#{File.dirname(genconf_dir)}/uninstall.sh" do
  source  'opt/dcos-grid/uninstall.sh'
  owner 'root'
  group 'root'
  mode '0755'
end

group 'nogroup' do
  action :create
end

if node['dcos-grid']['docker-engine']['setup']
  include_recipe 'dcos-grid::docker-engine'
end

case node['platform_family']
when 'rhel'
  service 'firewalld' do
    action [:stop, :disable]
  end

  [
    'tar',
    'xz',
    'unzip',
    'curl',
    'ipset',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  bash 'disable_selinux' do
    code <<-EOH
      setenforce Permissive
    EOH
    not_if 'getenforce | grep -i \'\(disabled\|permissive\)\''
  end
  template '/etc/selinux/config' do
    source  'etc/selinux/config'
    owner 'root'
    group 'root'
    mode '0644'
  end
when 'debian'
  [
    'tar',
    'xz-utils',
    'unzip',
    'curl',
    'ipset',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  # work around for DC/OS service units
  link '/usr/bin/mkdir' do
    to '/bin/mkdir'
  end
  link '/usr/bin/ln' do
    to '/bin/ln'
  end
  link '/usr/bin/tar' do
    to '/bin/tar'
  end
  link '/sbin/useradd' do
    to '/usr/sbin/useradd'
  end
end
