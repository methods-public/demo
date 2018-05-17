# Cookbook Name:: netstat
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Xabier de Zuazo
# License:: Apache License, Version 2.0
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

name 'netstat'
maintainer 'Xabier de Zuazo'
maintainer_email 'xabier@zuazo.org'
license 'Apache 2.0'
description 'Installs netstat network tool. Recommended for Docker containers.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.0'

if respond_to?(:source_url)
  source_url "https://github.com/zuazo/#{name}-cookbook"
end
if respond_to?(:issues_url)
  issues_url "https://github.com/zuazo/#{name}-cookbook/issues"
end

chef_version '>= 12' if respond_to?(:chef_version)

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'opensuse'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'suse'
supports 'ubuntu'

recipe 'netstat::default', 'Installs netstat.'

attribute 'netstat/packages',
          display_name: 'netstat packages',
          description: 'Package list to install netstat.',
          type: 'array',
          required: 'recommended',
          calculated: true
