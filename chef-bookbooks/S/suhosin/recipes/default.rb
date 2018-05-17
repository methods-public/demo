#
# Author:: Yosuke Inoue (<inoue@fieldweb.co.jp>)
# Cookbook Name:: suhosin
# Recipe:: default
#
# Copyright 2015, FIELD Co., Ltd.
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

include_recipe 'build-essential'

remote_file "#{Chef::Config[:file_cache_path]}/suhosin-#{node['suhosin']['version']}.tar.gz" do
  source node['suhosin']['source']
  checksum node['suhosin']['checksum']
  mode '0644'
  only_if "which php"
end


bash 'build suhosin' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -zxf suhosin-#{node['suhosin']['version']}.tar.gz
  cd suhosin-#{node['suhosin']['version']}
  phpize
  ./configure
  make
  make install
  EOF
  only_if "which php"
end

template "#{node['php']['ext_conf_dir']}/suhosin.ini" do
	source 'suhosin.ini.erb'
	cookbook 'suhosin'
	unless platform?('windows')
		owner 'root'
		group 'root'
		mode '0644'
	end
	notifies :reload, "service[apache2]", :immediately
end
