#
# Cookbook Name:: stenographer
# Recipe:: install
#
# Copyright 2015, Derek Ditch
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

# Currently just handle install RPM pacakge from repo
include_recipe 'yum-epel::default'

yum_repository 'cyberdev-capes' do
  description 'Packages for EL7 for CyberDEV projects'
  baseurl 'https://dl.bintray.com/cyberdev/capes'
  gpgcheck false
  action :create
end

package 'stenographer'
