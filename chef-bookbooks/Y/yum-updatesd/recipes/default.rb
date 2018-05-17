#
# Cookbook Name:: yum-updatesd
# Recipe:: default
#
# Author:: David Hofmann (<elmic11111@gmail.com>)
#
# Copyright 2015, David Hofmann
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

package 'yum-updatesd' do
  action :upgrade
  notifies :restart, 'service[yum-updatesd]'
end


service 'yum-updatesd' do
  service_name 'yum-updatesd'
  supports [:restart, :reload, :status, :stop]
  action [ :enable, :start ]
end

template '/etc/yum/yum-updatesd.conf' do
  source 'yum-updatesd.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  action :create
  notifies :restart, 'service[yum-updatesd]'
end