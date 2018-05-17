#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: cobbpass
# Attributes:: default
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

# username (and groupname) for the power user
default['cobbpass']['username'] = 'cobbpass'

# user's uid and gid
default['cobbpass']['uid'] = 450
default['cobbpass']['gid'] = 450

# user's home directory
default['cobbpass']['home'] = '/home/cobbpass'

# vault data bag name
default['cobbpass']['vault_name'] = 'cobbpass'

# vault's node client (the name of the node on "knife node list")
default['cobbpass']['vault_item'] = node['fqdn']

# client exact names
# this will be used instead of admins because currently chef clients
# can't read user keys.
default['cobbpass']['vault_client_admin'] = [ 'cobbpass' ]

# gem options and version
default['cobbpass']['gem_options'] = nil
default['cobbpass']['gem_source'] = nil
default['cobbpass']['gem_version'] = '~> 2.5'
