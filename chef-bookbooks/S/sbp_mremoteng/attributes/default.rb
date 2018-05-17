#
# Cookbook Name:: sbp_mremoteng
# Attribute:: default
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

default['mremoteng']['package_name']      = 'mRemoteNG'
default['mremoteng']['install_dir']       = 'C:\Program Files (x86)\mRemoteNG'
default['mremoteng']['version']           = '1.74.6023.15437'
default['mremoteng']['url']               = 'https://github.com/mRemoteNG/mRemoteNG/releases/download/v1.74/mRemoteNG-Installer-1.74.6023.15437.msi'
default['mremoteng']['checksum']          = '2d637780be5875221448dc259ce8ae8f5f9fc95adc87a2571610e305826df6a3'
default['mremoteng']['shared_config_dir'] = nil
default['mremoteng']['auto_expand']       = 'True'
