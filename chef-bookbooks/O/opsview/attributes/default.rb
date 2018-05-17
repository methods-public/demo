#
# Cookbook Name:: opsview
# Attributes:: default
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

# Name of the Chef role applied to the server(s)
# Used by clients to get a list of allowed IPs
default['opsview']['server_role'] = "opsview_host"
default['opsview']['plugin_dir'] = "/usr/local/nagios/libexec"