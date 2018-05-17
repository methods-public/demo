#
# Cookbook Name:: dbforbix
# Attributes:: drivers
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

# directory for jdbc drivers
default['dbforbix']['lib_dir'] = '/opt/dbforbix/dist/lib'

# mysql
default['dbforbix']['drivers']['mysql'] = false
default['dbforbix']['driver_mysql'] = 'https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz'
default['dbforbix']['driver_mysql_checksum'] = '2327d71182c7570d6aebf7a5183dda3170e75196bf4c6d506a22203eb75c88fc'

# pgsql
default['dbforbix']['drivers']['pgsql'] = false
default['dbforbix']['driver_pgsql'] = 'https://jdbc.postgresql.org/download/postgresql-42.2.2.jar'
default['dbforbix']['driver_pgsql_checksum'] = '1996524026a3027853f3932e8639ef813807d1b63fe14832f410fffa4274fa70'

# mssql
default['dbforbix']['drivers']['mssql'] = false
default['dbforbix']['driver_mssql'] = 'https://download.microsoft.com/download/3/F/7/3F74A9B9-C5F0-43EA-A721-07DA590FD186/sqljdbc_6.2.2.1_enu.tar.gz'
default['dbforbix']['driver_mssql_checksum'] = '4c1381ec7e1b9517abaf24a34b3a8051191bdd954e476e69f45cbf103580d8ec'
