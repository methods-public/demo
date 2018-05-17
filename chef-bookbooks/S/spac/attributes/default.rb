# Cookbook Name:: spac
# Attributes:: default
#
# Author:: Sander Botman (<sander.botman@gmail.com>)
# Copyright:: 2018 Sander Botman.
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

default['spac']['version'] = '0.1.0'
if platform_family?('mac_os_x')
  default['spac']['url'] = 'https://github.com/sbotman/spac/releases/download/v0.1.0/spac_mac'
  default['spac']['checksum'] = '348ab652648d5375b12b29a67f7b99fec3ab92742f9eaa664c394895d7588e6a'
elsif platform_family?('windows')
  default['spac']['url'] = 'https://github.com/sbotman/spac/releases/download/v0.1.0/spac.exe'
  default['spac']['checksum'] = '0fbf90e3910914033b4c58dd3299c8cb2de4f42f85a11266133f932b2367b076'
else
  default['spac']['url'] = 'https://github.com/sbotman/spac/releases/download/v0.1.0/spac'
  default['spac']['checksum'] = 'a0c93884037bd52f5d39ad88a901f0bda23ca5674c7e5f8b7596556b6ad97d9c'
end

default['spac']['server'] = '0.0.0.0'
default['spac']['port'] = 9000

# Add your app configuration, example:
# default['spac']['apps']['ssh'] = '0.0.0.0:22'
# default['spac']['apps']['rdp'] = '0.0.0.0:3389'

