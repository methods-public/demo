#
# Cookbook Name:: coopr
# Recipe:: default
#
# Copyright © 2013-2014 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'coopr::repo'

# Create our user and group
group node['coopr']['group'] do
  action :create
end

user node['coopr']['user'] do
  action :create
  gid node['coopr']['group']
end

include_recipe 'coopr::config'
include_recipe 'coopr::cli'
