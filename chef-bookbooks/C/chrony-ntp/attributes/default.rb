#
# Copyright (c) 2017 Make.org
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

cookbook_name = 'chrony-ntp'

# Package to install
default[cookbook_name]['package'] = 'chrony'

# Chrony configuration
# Each hash key is a chrony directive.
# If the same directive is needed many times, value should be an array
# If array is let empty, default arrays below is used.
default[cookbook_name]['config'] = {
  'server' => [],
  'stratumweight' => '0',
  'driftfile' => '/var/lib/chrony/drift',
  'rtcsync' => '',
  'makestep' => '10 3',
  'bindcmdaddress' => [],
  'keyfile' => '/etc/chrony.keys',
  'commandkey' => '1',
  'generatecommandkey' => '',
  'noclientlog' => '',
  'logchange' => '0.5',
  'logdir' => '/var/log/chrony'
}

# Default configuration arrays
default[cookbook_name]['default'] = {
  'server' => [
    '0.centos.pool.ntp.org iburst',
    '1.centos.pool.ntp.org iburst',
    '2.centos.pool.ntp.org iburst',
    '3.centos.pool.ntp.org iburst'
  ],
  'bindcmdaddress' => [
    '127.0.0.1',
    '::1'
  ]
}

# If chrony service is restarted when config file changes
default[cookbook_name]['auto_restart'] = true

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
