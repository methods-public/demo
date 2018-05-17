#
# Cookbook Name:: c-icap
# Attributes:: c-icap
# Author:: Rostyslav Fridman (<rostyslav.fridman@gmail.com>)
#
# Copyright 2014, Rostyslav Fridman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['c_icap']['pid_file'] = "/var/run/c-icap/c-icap.pid"
default['c_icap']['socket'] = "/var/run/c-icap/c-icap.ctl"
default['c_icap']['timeout'] = 300
default['c_icap']['keepalive']['max'] = 100
default['c_icap']['keepalive']['timeout'] = 600
default['c_icap']['servers']['start'] = 3
default['c_icap']['servers']['max'] = 10
default['c_icap']['spare_threads']['min'] = 10
default['c_icap']['spare_threads']['max'] = 20
default['c_icap']['threads']['per_child'] = 10
default['c_icap']['requests']['per_child'] = 10
default['c_icap']['port'] = 1344
default['c_icap']['contact'] = "contact@example.com"
default['c_icap']['tmp_dir'] = "/tmp"
default['c_icap']['log_dir'] = "/var/log/c-icap"
default['c_icap']['memobject']['max'] = 131072
default['c_icap']['debug'] = 0
default['c_icap']['modules_dir'] = "/usr/lib/c_icap"
default['c_icap']['services_dir'] = "/usr/lib/c_icap"
default['c_icap']['templates_dir'] = "/usr/share/c_icap/templates"
default['c_icap']['templates']['language'] = "en"
default['c_icap']['proxy']['users'] = "off"
default['c_icap']['proxy']['header'] = "X-Authenticated-User"
default['c_icap']['proxy']['encoded'] = "on"
default['c_icap']['module']['echo'] = true
default['c_icap']['module']['logger'] = false
default['c_icap']['module']['bdb_tables'] = false
default['c_icap']['module']['dnsbl_tables'] = false
default['c_icap']['module']['ldap_module'] = false
default['c_icap']['module']['url_check'] = false
default['c_icap']['module']['virus_scan'] = false
