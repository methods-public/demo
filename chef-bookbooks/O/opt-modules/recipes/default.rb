#
# Cookbook Name:: opt-modules
# Recipe:: default
#
# Copyright 2014, FutureGrid, Indiana University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


modules_download_url = node['opt-modules']['download_url']
modules_download_dir = node['opt-modules']['download_dir']
modules_install_dir = node['opt-modules']['install_dir']
modules_version = node['opt-modules']['version']

case node["platform"]
when "redhat", "centos"
  packages = %w[tcl tcl-devel tk tk-devel]
when "ubuntu", "debian"
  include_recipe 'apt'
  packages = %w[tcl tcl-dev tk tk-dev]
end

include_recipe 'build-essential'
packages.each do |pkg|
  package pkg do
    action :install
  end
end

directory modules_download_dir do
  action :create
end

remote_file "#{modules_download_dir}/modules-#{modules_version}.tar.gz" do
  source modules_download_url
  mode 00644
  owner "root"
  group "root"
  action :create_if_missing
  not_if { ::File.exists?("#{modules_install_dir}/Modules/#{modules_version}") }
end

execute "untar_modules_tarball" do
  command "tar zxvf modules-#{modules_version}.tar.gz"
  cwd modules_download_dir
  creates "#{modules_download_dir}/modules-#{modules_version}"
  only_if { ::File.exists?("#{modules_download_dir}/modules-#{modules_version}.tar.gz") }
end

script "install_modules" do
  interpreter "bash"
	user "root"
  cwd "#{modules_download_dir}/modules-#{modules_version}"
  code <<-EOH
  ./configure --prefix=#{modules_install_dir}
  make
  make install
  EOH
  creates "#{modules_install_dir}/Modules/#{modules_version}"
end

cookbook_file "#{modules_install_dir}/Modules/#{modules_version}/modulefiles/.defaultmodules" do
  owner "root"
	group "root"
	mode 00644
	action :create_if_missing
end

template "/etc/profile.d/modules.sh" do
  owner "root"
	group "root"
	mode 00644
	action :create
	variables(
    :modules_home => modules_install_dir,
		:modules_version => modules_version
	)
end
