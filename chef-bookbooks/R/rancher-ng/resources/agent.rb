
# Cookbook Name:: rancher-ng
# Resource:: rancher_ng_agent
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

attribute :image, kind_of: String, default: node['rancher_ng']['agent']['image']
attribute :version, kind_of: String, default: node['rancher_ng']['agent']['version']

attribute :auth_url, kind_of: String, default: nil
attribute :labels, kind_of: Hash, default: node['rancher_ng']['agent']['labels']
attribute :mount_point, kind_of: String, default: '/var/lib/rancher:/var/lib/rancher'
attribute :autoremove, kind_of: [TrueClass, FalseClass], default: node['rancher_ng']['agent']['autoremove']
attribute :privileged, kind_of: [TrueClass, FalseClass], default: true
