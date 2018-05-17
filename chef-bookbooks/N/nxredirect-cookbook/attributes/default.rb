#
# Copyright (c) 2016 Sam4Mobile, 2017 Make.org
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

cookbook_name = 'nxredirect-cookbook'

# Url and version
default[cookbook_name]['base_url'] =
  'https://gitlab.com/samuel.bernard/nxredirect'
base_url = node[cookbook_name]['base_url']

default[cookbook_name]['build'] = 2_967_352
build = node[cookbook_name]['build']

default[cookbook_name]['url'] =
  "#{base_url}/builds/#{build}/artifacts/download"

# Config
default[cookbook_name]['config'] = {
  'port' => 53,
  'primary' => '127.0.0.1:53053',
  'fallback' => '8.8.8.8:53'
}
config = node[cookbook_name]['config']
opts =
  "--port #{config['port']} "\
  "--primary #{config['primary']} "\
  "--fallback #{config['fallback']}"

# Where the binary will be installed
default[cookbook_name]['bin'] = '/usr/local/bin/nxredirect'

# Systemd service unit, include config
default[cookbook_name]['unit'] = {
  'Unit' => {
    'Description' => 'NXRedirect acts as a DNS Proxy which redirects '\
      'NXDomain responses from a primary DNS server to a fallback.',
    'After' => 'network.target'
  },
  'Service' => {
    'User' => 'root',
    'Group' => 'root',
    'SyslogIdentifier' => 'nxredirect',
    'Restart' => 'always',
    'ExecStart' => "#{node[cookbook_name]['bin']} #{opts}"
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}

# List of node where NXRedirect should be installed
# Empty (default) means all node should install it
# Expect a list of fqdn
default[cookbook_name]['servers'] = []

# Erlang stuff
default[cookbook_name]['erlang-solutions'] =
  'https://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm'

# Which erlang package do we install
default[cookbook_name]['erlang'] = 'erlang-kernel'
default[cookbook_name]['erlang_version'] = 'latest'

# Package containing wget and unzip commands
default[cookbook_name]['wget'] = 'wget'
default[cookbook_name]['unzip'] = 'unzip'

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
node[cookbook_name]['package_retries']
