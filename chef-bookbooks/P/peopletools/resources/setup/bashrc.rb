#
# Cookbook Name:: peopletools
# Resource:: bashrc
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

resource_name :peopletools_bashrc
default_action :create
property :cobol_dir, String, default: '/opt/microfocus/cobol'
property :custom_commands, Array, default: []
property :db2_instance_user, String
property :group, String, default: 'oinstall'
property :mode, String, default: '0644'
property :oracle_client_version, String, required: true
property :oracle_home, String, default: lazy { "/opt/oracle/psft/pt/oracle-client/#{oracle_client_version}" }
property :owner, String, name_property: true
property :path, String, default: lazy { "/home/#{owner}" }
property :ps_app_home, String, default: '/opt/oracle/psft/pt/ps_app_home'
property :ps_cfg_home, String, default: lazy { path }
property :ps_cust_home, String, default: lazy { "#{path}/custom" }
property :ps_home, String, default: lazy { "/opt/oracle/psft/pt/ps_home#{ps_home_version}" }
property :ps_home_version, String, required: true
property :tns_admin, String
property :tuxedo_dir, String, default: lazy { "/opt/oracle/psft/pt/bea/tuxedo/tuxedo#{tuxedo_version}" }
property :tuxedo_version, String, required: true

action :create do
  # tnsnames.ora file
  template ::File.join(path, '.bashrc') do
    source 'setup/bashrc/.bashrc.erb'
    cookbook 'peopletools'
    mode new_resource.mode
    owner new_resource.owner
    group new_resource.group
    variables(
      cobol_dir: cobol_dir,
      custom_commands: custom_commands,
      db2_instance_user: db2_instance_user,
      oracle_home: oracle_home,
      ps_app_home: ps_app_home,
      ps_cfg_home: ps_cfg_home,
      ps_cust_home: ps_cust_home,
      ps_home: ps_home,
      tns_admin: tns_admin,
      tuxedo_dir: tuxedo_dir
    )
    action :create
  end
end
