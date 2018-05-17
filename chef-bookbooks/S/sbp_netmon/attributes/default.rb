#
# Cookbook Name:: sbp_netmon
# Attribute:: default
#
# Copyright 2014, Schuberg Philis
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

default['netmon']['package_name'] = 'Microsoft Network Monitor 3.4'

if node['kernel']['machine'] =~ /x86_64/
  default['netmon']['url']      = 'http://download.microsoft.com/download/7/1/0/7105C7FF-768E-4472-AFD5-F29108D1E383/NM34_x64.exe'
  default['netmon']['checksum'] = 'ab0b46acc1439077d801356fc5ac5af5f05349db249e87f1afede9e69edf7cf6'
else
  default['netmon']['url']      = 'http://download.microsoft.com/download/7/1/0/7105C7FF-768E-4472-AFD5-F29108D1E383/NM34_x86.exe'
  default['netmon']['checksum'] = '890e0d04f2028b9b74b2073baa7eccbe5810c6608e9ce647ed4310ed8e138156'
end
