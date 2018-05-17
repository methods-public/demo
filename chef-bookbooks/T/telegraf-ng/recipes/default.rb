#
# Cookbook Name:: telegraf-ng
# Recipe:: default
#
# Copyright 2015, Virender Khatri
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

if Chef::Resource::ChefGem.method_defined?(:compile_time)
  chef_gem 'toml-rb' do
    compile_time true
  end
else
  chef_gem 'toml-rb' do
    action :nothing
  end.run_action(:install)
end

include_recipe 'yum-plugin-versionlock::default' if node['platform'] == 'rhel' || node['platform'] == 'centos'

include_recipe 'telegraf-ng::install'
include_recipe 'telegraf-ng::config'
include_recipe 'telegraf-ng::inputs'
include_recipe 'telegraf-ng::outputs'
include_recipe 'telegraf-ng::service'
