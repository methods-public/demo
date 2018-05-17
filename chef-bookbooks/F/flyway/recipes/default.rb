#
# Cookbook Name:: flyway
# Recipe:: default
#
# Copyright (C) 2015 base2Services
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

flyway = node['flyway']

user flyway['user'] do
  comment 'Flyway System User'
  home flyway['install_dir']
  shell '/sbin/nologin'
  system true
  action [:create, :lock]
end

group flyway['group'] do
  append true
  members flyway['user']
  action :create
  only_if { flyway['user'] != flyway['group'] }
end

ark 'flyway' do
  url flyway['url']
  path flyway['install_dir']
  owner flyway['user']
  action :put
end

template "#{node['flyway']['install_dir']}/flyway/conf/flyway.conf" do
  source 'flyway.conf.erb'
  owner flyway['user']
end
