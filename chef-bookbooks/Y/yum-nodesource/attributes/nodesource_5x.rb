#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: yum-nodesource
# Attributes:: nodesource_5x
#
# Copyright 2017, Movile
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

default['yum']['nodesource_5x']['repositoryid'] = 'nodesource_5x'
default['yum']['nodesource_5x']['gpgkey'] = 'https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL'
default['yum']['nodesource_5x']['description'] = 'Nodesource NodeJS 5.x RPM Repository'
default['yum']['nodesource_5x']['failovermethod'] = 'priority'
default['yum']['nodesource_5x']['gpgcheck'] = true
default['yum']['nodesource_5x']['enabled'] = true

case node['platform']
when "amazon"
  default['yum']['nodesource_5x']['baseurl'] = 'https://rpm.nodesource.com/pub_5.x/el/6/x86_64/'
else
  case node['platform_version'].to_i
  when 6
    default['yum']['nodesource_5x']['baseurl'] = 'https://rpm.nodesource.com/pub_5.x/el/6/x86_64/'
  when 7
    default['yum']['nodesource_5x']['baseurl'] = 'https://rpm.nodesource.com/pub_5.x/el/7/x86_64/'
  end
end
