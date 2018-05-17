#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-s3cmd
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

python_package 's3cmd' do
  action :install
  version node['alphard']['s3cmd']['version']
end

directory node['alphard']['s3cmd']['configuration_directory'] do
  user node['alphard']['s3cmd']['user']
  group node['alphard']['s3cmd']['group']
  mode '0755'
  recursive true
  action :create
end

template node['alphard']['s3cmd']['configuration_file'] do
  source 'config.erb'
  owner node['alphard']['s3cmd']['user']
  group node['alphard']['s3cmd']['group']
  mode '0644'
  cookbook 'alphard-chef-s3cmd'
  action :create
end
