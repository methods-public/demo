#
# Cookbook Name:: peopletools
# Resource:: ps_app_home
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

resource_name :peopletools_ps_app_home
default_action :deploy
property :archive_url, String, required: true
property :db_platform, equal_to: %w[ORACLE DB2ODBC DB2UNIX], default: 'ORACLE'
property :deploy_location, String, default: '/opt/oracle/psft/pt/ps_app_home'
property :deploy_user, String, default: 'psadm3'
property :deploy_group, String, default: 'appinst'
property :extract_only, [TrueClass, FalseClass], default: false
property :version, String, name_property: true

action :deploy do # rubocop:disable Metrics/BlockLength
  # extract ps_app_home archive
  ark ::File.basename(deploy_location) do
    path ::File.dirname(deploy_location)
    url archive_url
    owner deploy_user
    group deploy_group
    strip_components 0
    not_if { ::File.exist?(deploy_location) }
    notifies :run, "ruby_block[chmod_R_#{deploy_location}]", :immediately
    notifies :run, "ruby_block[db_type_#{deploy_location}]", :immediately
    action :put
  end

  # ps_app_home directory permissions
  ruby_block "chmod_R_#{deploy_location}" do
    block do
      FileUtils.chmod_R 0_755, deploy_location
    end
    only_if { ::File.directory?(deploy_location) }
    action :nothing
  end

  # ps_app_home db_type
  ruby_block "db_type_#{deploy_location}" do
    block do
      # set db_type
      case db_platform
      when 'ORACLE'
        db_type = 'ORA'
      when 'DB2ODBC'
        db_type = 'DB2'
      when 'DB2UNIX'
        db_type = 'DBX'
      else
        db_type = nil
        raise 'Invalid db_platform'
      end

      # move db_type files and folders
      FileUtils.mv(::File.join(deploy_location, db_type, 'scripts'), deploy_location)
      FileUtils.mv(Dir.glob(::File.join(deploy_location, db_type, 'setup', 'dbcodes.*'))[0], ::File.join(deploy_location, 'setup'))

      # remove database directories
      %w[ORA DB2 DBX].each do |d|
        FileUtils.remove_dir(::File.join(deploy_location, d), true)
      end
    end
    not_if { extract_only || !::File.directory?(deploy_location) }
    action :nothing
  end
end # rubocop:enable Metrics/BlockLength
