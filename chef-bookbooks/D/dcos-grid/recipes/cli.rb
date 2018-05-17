#
# Cookbook Name:: dcos-grid
# Recipe:: cli
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

genconf_dir = node['dcos-grid']['bootstrap']['genconf_dir']
cli_ver = node['dcos-grid']['cli']['version']

resources(directory: genconf_dir) rescue directory genconf_dir do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

=begin
# old way
case node['platform_family']
when 'rhel'
  # TODO: package installation.
when 'debian'
  [
    'curl',
    'python-pip',
    'python-virtualenv',
    'virtualenv',
  ].each {|pkg|
    package pkg do
      action :install
    end
  }
end
=end

[
  'curl',
].each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

template "#{File.dirname(genconf_dir)}/cli_setup.sh" do
  source  'opt/dcos-grid/cli_setup.sh'
  owner 'root'
  group 'root'
  mode '0755'
end

bash 'install_dcos_cli' do
  code <<-"EOH"
    #{File.dirname(genconf_dir)}/cli_setup.sh -y
  EOH
  not_if "[ \"$(dcos --version | grep dcoscli.version | awk -F '=' '{print $2}')\" = #{cli_ver} ]"
  not_if { ::File.exist?(node['dcos-grid']['cli']['install_path']) } unless node['dcos-grid']['cli']['auto_upgrade']
end
