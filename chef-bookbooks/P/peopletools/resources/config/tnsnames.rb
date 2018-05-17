#
# Cookbook Name:: peopletools
# Resource:: tnsnames
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

resource_name :peopletools_tnsnames
default_action :create
property :db_host, String, required: true
property :db_name, String, required: true
property :db_port, String, default: '1521'
property :db_protocol, equal_to: %w[SDP TCP TCPS], default: 'TCP'
property :db_service_name, String, default: lazy { db_name }
property :group, String, default: 'oinstall'
property :mode, String, default: '0644'
property :oracle_client_version, String, name_property: true
property :owner, String, default: 'oracle'
property :path, String, default: lazy { "/opt/oracle/psft/pt/oracle-client/#{oracle_client_version}/network/admin" }
property :server, equal_to: %w[DEDICATED SHARED], default: 'DEDICATED'

action :create do
  # tnsnames.ora file
  template ::File.join(path, 'tnsnames.ora') do
    source 'config/tnsnames/tnsnames.ora.erb'
    cookbook 'peopletools'
    mode new_resource.mode
    owner new_resource.owner
    group new_resource.group
    variables(
      db_host: db_host,
      db_name: db_name,
      db_port: db_port,
      db_protocol: db_protocol,
      db_service_name: db_service_name,
      server: server
    )
    action :create
  end
end
