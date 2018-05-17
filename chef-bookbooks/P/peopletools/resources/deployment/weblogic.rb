#
# Cookbook Name:: peopletools
# Resource:: weblogic
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

resource_name :peopletools_weblogic
default_action :deploy
property :archive_url, String, required: true
property :deploy_location, String, default: '/opt/oracle/psft/pt/bea'
property :deploy_user, String, default: 'psadm1'
property :deploy_group, String, default: 'oinstall'
property :home_name, String, default: 'OraWLHome'
property :inventory_location, String, default: '/opt/oracle/psft/db/oraInventory'
property :inventory_user, String, default: 'oracle'
property :inventory_group, String, default: 'oinstall'
property :jdk_location, String, default: lazy { "/opt/oracle/psft/pt/jdk#{jdk_version}" }
property :jdk_version, String, required: true
property :tmp_dir, String, default: '/opt/oracle/psft/pt/wl_tmp'
property :version, String, name_property: true

action :deploy do # rubocop:disable Metrics/BlockLength
  # inventory
  peopletools_inventory inventory_location do
    inventory_location new_resource.inventory_location
    inventory_user new_resource.inventory_user
    inventory_group new_resource.inventory_group
  end

  # extract weblogic archive
  ark ::File.basename(tmp_dir) do
    path ::File.dirname(tmp_dir)
    url archive_url
    owner deploy_user
    group deploy_group
    mode 0_777
    strip_components 0
    not_if { ::File.exist?(::File.join(deploy_location, 'wlserver')) }
    notifies :run, "ruby_block[chmod_R_#{tmp_dir}]", :immediately
    notifies :create, "directory[#{deploy_location}]", :immediately
    notifies :run, 'execute[weblogic_pasteBinary]', :immediately
    notifies :run, "ruby_block[chmod_R_#{deploy_location}]", :immediately
    notifies :run, "ruby_block[chmod_R_#{::File.join(deploy_location, 'tuxedo')}]", :immediately
    notifies :delete, "directory[#{tmp_dir}]", :immediately
    action :put
  end

  # weblogic tmp directory permissions
  ruby_block "chmod_R_#{tmp_dir}" do
    block do
      FileUtils.chmod_R 0_777, tmp_dir
    end
    only_if { ::File.directory?(tmp_dir) }
    action :nothing
  end

  # weblogic directory
  directory deploy_location do
    owner deploy_user
    group deploy_group
    mode '0775'
    recursive true
    action :nothing
  end

  # execute weblogic pasteBinary
  execute 'weblogic_pasteBinary' do
    command "export T2P_JAVA_OPTIONS=\"-d64 -Djava.io.tmpdir=#{tmp_dir}\" && " \
    "su - #{deploy_user} -c \"#{tmp_dir}/pasteBinary.sh " \
    "-javaHome #{jdk_location} -archiveLoc #{tmp_dir}/pt-weblogic-copy.jar " \
    "-targetMWHomeLoc #{deploy_location} -targetOracleHomeName #{home_name} " \
    "-invPtrLoc #{inventory_location}/oraInst.loc -executeSysPrereqs false " \
    "-silent true -logDirLoc #{tmp_dir}\""
    only_if { ::File.file?(::File.join(tmp_dir, 'pasteBinary.sh')) }
    action :nothing
  end

  # weblogic directory permissions
  ruby_block "chmod_R_#{deploy_location}" do
    block do
      FileUtils.chmod_R 0_775, deploy_location
    end
    only_if { ::File.directory?(deploy_location) }
    action :nothing
  end

  # tuxedo directory permissions
  ruby_block "chmod_R_#{::File.join(deploy_location, 'tuxedo')}" do
    block do
      FileUtils.chmod_R 0_755, ::File.join(deploy_location, 'tuxedo')
    end
    only_if { ::File.directory?(::File.join(deploy_location, 'tuxedo')) }
    action :nothing
  end

  # weblogic tmp directory
  directory tmp_dir do
    owner deploy_user
    group deploy_group
    recursive true
    action :nothing
  end
end # rubocop:enable Metrics/BlockLength
