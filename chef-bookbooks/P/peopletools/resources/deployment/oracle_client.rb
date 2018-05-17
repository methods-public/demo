#
# Cookbook Name:: peopletools
# Resource:: oracle_client
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

resource_name :peopletools_oracle_client
default_action :deploy
property :archive_url, String, required: true
property :deploy_location, String, default: lazy { "/opt/oracle/psft/pt/oracle-client/#{version}" }
property :deploy_user, String, default: 'oracle'
property :deploy_group, String, default: 'oinstall'
property :home_name, String, default: 'OraClient12cHome'
property :inventory_location, String, default: '/opt/oracle/psft/db/oraInventory'
property :inventory_user, String, default: 'oracle'
property :inventory_group, String, default: 'oinstall'
property :tmp_dir, String, default: lazy { "/opt/oracle/psft/pt/oracle-client/#{version}/oc_tmp" }
property :version, String, name_property: true

action :deploy do # rubocop:disable Metrics/BlockLength
  # package gcc required to fix issue with libclntshcore.so.12.1
  package 'gcc'

  # inventory
  peopletools_inventory inventory_location do
    inventory_location new_resource.inventory_location
    inventory_user new_resource.inventory_user
    inventory_group new_resource.inventory_group
  end

  # extract oracle_client archive
  ark ::File.basename(deploy_location) do
    path ::File.dirname(deploy_location)
    url archive_url
    owner deploy_user
    group deploy_group
    strip_components 0
    not_if { ::File.exist?(deploy_location) }
    notifies :run, "ruby_block[chmod_R_#{deploy_location}]", :immediately
    notifies :create, "directory[#{tmp_dir}]", :immediately
    notifies :run, 'execute[oracle_client_runInstaller]', :immediately
    notifies :run, 'execute[oracle_client_orainstRoot]', :immediately
    notifies :delete, "directory[#{tmp_dir}]", :immediately
    action :put
  end

  # oracle_client directory permissions
  ruby_block "chmod_R_#{deploy_location}" do
    block do
      FileUtils.chmod_R 0_755, deploy_location
    end
    only_if { ::File.directory?(deploy_location) }
    action :nothing
  end

  # oracle_client tmp directory
  directory tmp_dir do
    owner deploy_user
    group deploy_group
    mode '0777'
    recursive true
    action :nothing
  end

  # execute oracle_client runInstaller
  execute 'oracle_client_runInstaller' do
    command "export TMP=#{tmp_dir} && su - #{deploy_user} -c " \
            "\"#{::File.join(deploy_location, 'oui', 'bin', 'runInstaller')} -silent " \
            "-waitforcompletion -nowait -clone -invPtrLoc #{inventory_location}/oraInst.loc " \
            "ORACLE_BASE=#{deploy_location} ORACLE_HOME=#{deploy_location} " \
            "ORACLE_HOME_NAME=#{home_name}\""
    only_if { ::File.file?(::File.join(deploy_location, 'oui', 'bin', 'runInstaller')) }
    action :nothing
  end

  # execute oracle_client orainstRoot
  execute 'oracle_client_orainstRoot' do
    command "#{::File.join(inventory_location, 'orainstRoot.sh')} >/dev/null"
    only_if do
      ::File.file?(::File.join(inventory_location, 'orainstRoot.sh')) &&
        ::File.readlines(::File.join(inventory_location, 'ContentsXML', 'inventory.xml')).grep(Regexp.new(home_name)).any?
    end
    action :nothing
  end
end # rubocop:enable Metrics/BlockLength
