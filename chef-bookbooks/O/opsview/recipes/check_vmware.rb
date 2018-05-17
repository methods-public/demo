#
# Cookbook Name:: opsview
# Recipe:: check_vmware
#
# Copyright 2015, Biola University
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

# Install dependencies for vmware plugin
include_recipe "vsphere_perl_sdk"
package "libnagios-plugin-perl"

# Retrieve the plugin
remote_file "/usr/local/nagios/libexec/check_vmware_api.pl" do
  source node['opsview']['check_vmware']['plugin_url']
  checksum node['opsview']['check_vmware']['plugin_checksum']
  owner "nagios"
  group "nagios"
  mode "0755"
  action :create_if_missing
end