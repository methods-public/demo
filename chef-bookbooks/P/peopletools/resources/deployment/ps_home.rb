#
# Cookbook Name:: peopletools
# Resource:: ps_home
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

resource_name :peopletools_ps_home
default_action :deploy
property :archive_url, String, required: true
property :db_platform, equal_to: %w[ORACLE DB2ODBC DB2UNIX], default: 'ORACLE'
property :deploy_location, String, default: lazy { "/opt/oracle/psft/pt/ps_home#{version}" }
property :deploy_user, String, default: 'psadm1'
property :deploy_group, String, default: 'oinstall'
property :extract_only, [TrueClass, FalseClass], default: false
property :unicode_db, [TrueClass, FalseClass], default: true
property :version, String, name_property: true

action :deploy do # rubocop:disable Metrics/BlockLength
  # extract ps_home archive
  ark ::File.basename(deploy_location) do
    path ::File.dirname(deploy_location)
    url archive_url
    owner deploy_user
    group deploy_group
    strip_components 0
    not_if { ::File.exist?(deploy_location) }
    notifies :run, "ruby_block[chmod_R_#{deploy_location}]", :immediately
    notifies :run, "ruby_block[db_type_#{deploy_location}]", :immediately
    notifies :run, "ruby_block[non_unicode_#{deploy_location}]", :immediately
    action :put
  end

  # ps_home directory permissions
  ruby_block "chmod_R_#{deploy_location}" do
    block do
      FileUtils.chmod_R 0_755, deploy_location
    end
    only_if { ::File.directory?(deploy_location) }
    action :nothing
  end

  # ps_home db_type
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
      FileUtils.mv(::File.join(deploy_location, db_type, 'bin', 'sqr'), ::File.join(deploy_location, 'bin'))
      FileUtils.mv(::File.join(deploy_location, db_type, 'peopletools.properties'), deploy_location)
      FileUtils.mv(::File.join(deploy_location, db_type, 'psconfig.sh'), deploy_location)
      FileUtils.mv(::File.join(deploy_location, db_type, 'scripts'), deploy_location)
      FileUtils.mv(::File.join(deploy_location, db_type, 'setup', 'psdb.sh'), ::File.join(deploy_location, 'setup'))
      FileUtils.mv(::File.join(deploy_location, db_type, 'sqr'), deploy_location)

      # remove database directories
      %w[ORA DB2 DBX].each do |d|
        FileUtils.remove_dir(::File.join(deploy_location, d), true)
      end
    end
    not_if { extract_only || !::File.directory?(deploy_location) }
    action :nothing
  end

  # ps_home non-unicode
  ruby_block "non_unicode_#{deploy_location}" do
    block do
      # remove the unicode.cfg file
      FileUtils.rm_rf(File.join(deploy_location, 'setup', 'unicode.cfg'))

      # update the unicode value in peopletools.properties file
      pt_prop_file = Chef::Util::FileEdit.new(::File.join(deploy_location, 'peopletools.properties'))
      pt_prop_file.search_file_replace('/unicodedb=1/', 'unicodedb=0')
      pt_prop_file.write_file
    end
    not_if { extract_only || unicode_db || !::File.directory?(deploy_location) }
    action :nothing
  end
end # rubocop:enable Metrics/BlockLength
