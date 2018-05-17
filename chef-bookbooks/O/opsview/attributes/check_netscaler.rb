#
# Cookbook Name:: opsview
# Attributes:: check_netscaler
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

default['opsview']['check_netscaler']['health']['plugin_url'] = "https://raw.githubusercontent.com/biola/nagios-plugins/master/check_netscaler_health.rb"
default['opsview']['check_netscaler']['health']['plugin_checksum'] = "5f79be8eedd6d537e245cce916873fe55846625c7e7edba4a61fa3fba541de72"

default['opsview']['check_netscaler']['vserver']['plugin_url'] = "https://raw.githubusercontent.com/biola/nagios-plugins/master/check_netscaler_vserver.rb"
default['opsview']['check_netscaler']['vserver']['plugin_checksum'] = "dbb0b985234882d81ed75393cf697d11d8d01cd7ca035e9717bb8d9a9c9ee752"