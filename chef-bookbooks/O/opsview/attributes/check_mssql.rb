#
# Cookbook Name:: opsview
# Attributes:: check_mssql
#
# Copyright 2015, Biola University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE_2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['opsview']['check_mssql']['plugin_version'] = "1.5.20.6"
default['opsview']['check_mssql']['plugin_url'] = "http://labs.consol.de/download/shinken-nagios-plugins/check_mssql_health-1.5.20.6.tar.gz"
default['opsview']['check_mssql']['plugin_checksum'] = "c7eb3d6f328659727ac0f9002f65f89381db6c714251d8f4887cd9163a362d62"
default['opsview']['check_mssql']['statefiles_dir'] = "/tmp/check_mssql_health"
default['opsview']['check_mssql']['monitored_server_role'] = "mssql_server"
