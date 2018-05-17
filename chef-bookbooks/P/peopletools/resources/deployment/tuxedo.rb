#
# Cookbook Name:: peopletools
# Resource:: tuxedo
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

resource_name :peopletools_tuxedo
default_action :deploy
property :archive_url, String, required: true
property :deploy_location, String, default: '/opt/oracle/psft/pt/bea/tuxedo'
property :deploy_user, String, default: 'psadm1'
property :deploy_group, String, default: 'oinstall'
property :home_name, String, default: 'OraTuxHome'
property :inventory_location, String, default: '/opt/oracle/psft/db/oraInventory'
property :inventory_user, String, default: 'oracle'
property :inventory_group, String, default: 'oinstall'
property :jdk_location, String, required: lazy { Gem::Version(version) >= Gem::Version('12.2') }
property :tlisten_password, String, required: true
property :version, String, name_property: true

action :deploy do # rubocop:disable Metrics/BlockLength
  # inventory
  peopletools_inventory inventory_location do
    inventory_location new_resource.inventory_location
    inventory_user new_resource.inventory_user
    inventory_group new_resource.inventory_group
  end

  # extract tuxedo archive
  ark ::File.basename(deploy_location) do
    path ::File.dirname(deploy_location)
    url archive_url
    owner deploy_user
    group deploy_group
    strip_components 0
    not_if { ::File.exist?(::File.join(deploy_location, 'tuxedo')) }
    notifies :run, "ruby_block[chmod_R_#{deploy_location}]", :immediately
    notifies :run, 'execute[tuxedo_runInstaller]', :immediately
    action :put
  end

  # tuxedo directory permissions
  ruby_block "chmod_R_#{deploy_location}" do
    block do
      FileUtils.chmod_R 0_755, deploy_location
    end
    only_if { ::File.directory?(deploy_location) }
    action :nothing
  end

  # execute tuxedo runInstaller
  execute 'tuxedo_runInstaller' do
    if Gem::Version.new(version) >= Gem::Version.new('12.2')
      command  "su - #{deploy_user} -c \"#{::File.join(deploy_location, 'oui', 'bin', 'runInstaller')} " \
      "-silent -clone -waitforcompletion -nowait -jreLoc #{jdk_location} -invPtrLoc #{inventory_location}/oraInst.loc " \
      "ORACLE_HOME=#{deploy_location} ORACLE_HOME_NAME=#{home_name} TLISTEN_PASSWORD=#{tlisten_password} -debug\""
    else
      command "su - #{deploy_user} -c \"#{::File.join(deploy_location, 'oui', 'bin', 'runInstaller')} " \
      "-silent -clone -waitforcompletion -nowait -invPtrLoc #{inventory_location}/oraInst.loc " \
      "ORACLE_HOME=#{deploy_location} ORACLE_HOME_NAME=#{home_name} TLISTEN_PASSWORD=#{tlisten_password}\""
    end
    sensitive new_resource.sensitive
    only_if { ::File.file?(::File.join(deploy_location, 'oui', 'bin', 'runInstaller')) }
    action :nothing
  end
end # rubocop:enable Metrics/BlockLength
