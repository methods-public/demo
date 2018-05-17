
# Cookbook Name:: rancher-ng
# Resource:: rancher_ng_server
#
# Copyright (C) 2017 Alexander Merkulov
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

actions :create, :delete

default_action :create

attribute :name, name_attribute: true, kind_of: String
attribute :cookbook, kind_of: String, default: 'rancher-ng'

attribute :db_dir, kind_of: String, default: node['rancher_ng']['server']['db_dir']
attribute :image, kind_of: String, default: node['rancher_ng']['server']['image']
attribute :version, kind_of: String, default: node['rancher_ng']['server']['version']

attribute :port, kind_of: String, default: nil
attribute :detach, kind_of: [TrueClass, FalseClass], default: true
attribute :restart_policy, kind_of: String, default: 'unless-stopped'

attribute :external_db, kind_of: [TrueClass, FalseClass], default: node['rancher_ng']['server']['external_db']

attribute :db_container, kind_of: String, default: node['rancher_ng']['server']['db_container']
attribute :db_container_version, kind_of: String, default: node['rancher_ng']['server']['db_container_version']
attribute :db_container_command, kind_of: String, default: node['rancher_ng']['server']['db_container_command']

attribute :db_host, kind_of: String, default: node['rancher_ng']['server']['db_host']
attribute :db_port, kind_of: String, default: node['rancher_ng']['server']['db_port']
attribute :db_user, kind_of: String, default: node['rancher_ng']['server']['db_user']
attribute :db_pass, kind_of: String, default: node['rancher_ng']['server']['db_pass']
attribute :db_name, kind_of: String, default: node['rancher_ng']['server']['db_name']
