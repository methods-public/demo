#
# Cookbook Name:: sbp_tortoisegit
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

if kernel['machine'] =~ /x86_64/
  default['tortoisegit']['package_name'] = 'TortoiseGit 1.8.8.0 (64 bit)'
  default['tortoisegit']['url'] = 'http://download.tortoisegit.org/tgit/1.8.8.0/TortoiseGit-1.8.8.0-64bit.msi'
  default['tortoisegit']['checksum'] = '43786da8d949bcddc1d895deecb6d8a3102dac75c8dbdb2e6db0b297708da571'
else
  default['tortoisegit']['package_name'] = 'TortoiseGit 1.8.8.0 (32 bit)'
  default['tortoisegit']['url'] = 'http://download.tortoisegit.org/tgit/1.8.8.0/TortoiseGit-1.8.8.0-32bit.msi'
  default['tortoisegit']['checksum'] = '458e3263c3e206e2663b3cee9693a71e4dee9c0ee57a4712bea820a1538a934c'
end
