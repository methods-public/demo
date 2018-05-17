#
# Cookbook Name:: peopletools
# Resource:: inventory
#
# Copyright 2016 University of Derby
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

resource_name :peopletools_inventory
default_action :create
property :inventory_location, String, default: '/opt/oracle/psft/db/oraInventory'
property :inventory_user, String, default: 'oracle'
property :inventory_group, String, default: 'oinstall'
property :inventory_minimum_ver, String, default: '2.1.0.6.0'
property :inventory_saved_with, String, default: '13.2.0.0.0'

action :create do # rubocop:disable Metrics/BlockLength
  # directories
  [
    inventory_location,
    ::File.join(inventory_location, 'logs'),
    ::File.join(inventory_location, 'ContentsXML')
  ]
    .each do |d|
    directory d do
      owner inventory_user
      group inventory_group
      mode '0770'
      recursive true
    end
  end

  # inventory pointer file
  template ::File.join(inventory_location, 'oraInst.loc') do
    source 'deployment/inventory/oraInst.loc.erb'
    cookbook 'peopletools'
    mode '0770'
    owner inventory_user
    group inventory_group
    variables(
      inst_group: inventory_group,
      inventory_loc: inventory_location
    )
    action :create_if_missing
  end

  # inventory file
  template ::File.join(inventory_location, 'ContentsXML', 'inventory.xml') do
    source 'deployment/inventory/inventory.xml.erb'
    cookbook 'peopletools'
    mode '0770'
    owner inventory_user
    group inventory_group
    variables(
      minimum_ver: inventory_minimum_ver,
      saved_with: inventory_saved_with
    )
    action :create_if_missing
  end
end # rubocop:enable Metrics/BlockLength
