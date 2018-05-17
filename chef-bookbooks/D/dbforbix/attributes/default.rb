#
# Cookbook Name:: dbforbix
# Attributes:: default
#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Author:: Tiago Cruz (tiago.cruz@movile.com)
#
# Copyright:: 2017-2018, Movile
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# installation
#

# install method, options: git or archive
default['dbforbix']['install_method'] = 'git'

# git url
default['dbforbix']['url_git'] = 'https://github.com/smartmarmot/DBforBIX.git'

# archive url
default['dbforbix']['url_archive'] = 'http://internal.example.com/dbforbix3.zip'

# installation directory
default['dbforbix']['dir'] = '/opt/dbforbix'

# install only one time or keep upgrading?
default['dbforbix']['install_only'] = true

#
# configuration
#

# frequency of update config in seconds
default['dbforbix']['config_update_freq'] = 120

# log options 
default['dbforbix']['log_level'] = 'INFO'
default['dbforbix']['log_file'] = '/var/log/dbforbix.log'

# pool and connections options
default['dbforbix']['pool_login_timeout'] = '15'

#
# server and database configurations
#

default['dbforbix']['zabbix'] = {}
default['dbforbix']['databases'] = {
  'DB1' => {
    'Type' => 'pgsql',
    'Url' => 'jdbc:postgresql://localhost:5432/',
    'User' => 'user',
    'Password' => 'passwd'
  }
}

#
# misc
#

# java binary location
default['dbforbix']['java_exec'] = '/usr/bin/java'
