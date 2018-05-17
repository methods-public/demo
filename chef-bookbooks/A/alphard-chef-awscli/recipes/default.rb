#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-awscli
# Recipe:: default
#
# Copyright:: 2017, Hydra Technologies, Inc
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

include_recipe 'poise-python'

python_package 'awscli' do
  action :install
  version node['alphard']['awscli']['version']
end

directory node['alphard']['awscli']['configuration_directory'] do
  user node['alphard']['awscli']['user']
  group node['alphard']['awscli']['group']
  mode '0755'
  recursive true
  action :create
end

template node['alphard']['awscli']['configuration_file'] do
  source 'config.erb'
  mode '0644'
  owner node['alphard']['awscli']['user']
  group node['alphard']['awscli']['group']
  cookbook 'alphard-chef-awscli'
  action :create
end
