#
# Attribute Name:: flyway
# Recipe:: default
#
# Copyright (C) 2015 base2Services
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

default['flyway']['version'] = '3.2.1'
default['flyway']['base_url'] = 'https://bintray.com/artifact/download/business/maven'

case node['platform_family']
when 'debian'
  default['flyway']['url'] = "#{node['flyway']['base_url']}/flyway-commandline-#{node['flyway']['version']}-linux-x64.tar.gz"
  default['flyway']['install_dir'] = '/opt'
when 'rhel'
  default['flyway']['url'] = "#{node['flyway']['base_url']}/flyway-commandline-#{node['flyway']['version']}-linux-x64.tar.gz"
  default['flyway']['install_dir'] = '/opt'
when 'windows'
  default['flyway']['url'] = "#{node['flyway']['base_url']}/flyway-commandline-#{node['flyway']['version']}-windows-x64.zip"
  default['flyway']['install_dir'] = 'C:/'
end

default['flyway']['user'] = 'flyway'
default['flyway']['group'] = 'flyway'

# used to generate the flyway.conf file you can override any flyway config
default['flyway']['conf'] = [
  # url: 'jdbc:mysql://localhost/testdb',
  # user: 'mysql',
  # password: 'mysql'
]
