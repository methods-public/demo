#
# Cookbook Name:: opt-python
# Recipe:: _source
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2014, FutureGrid Project, Indiana University
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

node['opt-python']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

directory node['opt-python']['install_dir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

directory node['opt-python']['download_dir'] do
  owner "root"
  group "root"
  action :create
end

remote_file "#{node['opt-python']['download_dir']}/Python-#{node['opt-python']['version']}.tgz" do
  source node['opt-python']['download_url']
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  not_if { ::File.exists?("#{node['opt-python']['install_dir']}/python-#{node['opt-python']['version']}") }
end

execute "extract_python" do
  cwd node['opt-python']['download_dir']
  command "tar zxf Python-#{node['opt-python']['version']}.tgz"
  creates "Python-#{node['opt-python']['version']}"
  only_if { ::File.exists?("#{node['opt-python']['download_dir']}/Python-#{node['opt-python']['version']}.tgz")}
end

script "install_python" do
  interpreter "bash"
  cwd "#{node['opt-python']['download_dir']}/Python-#{node['opt-python']['version']}"
  code <<-EOH
  ./configure --prefix=#{node['opt-python']['install_dir']}/python-#{node['opt-python']['version']}
  make
  make install
  EOH
  creates "#{node['opt-python']['install_dir']}/python-#{node['opt-python']['version']}"
end

