#
# Cookbook Name:: netdevops
# Atributes:: language
#
# Copyright 2015 John Deatherage
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

# -----------------------------------------------------------------------------
# Ruby
# -----------------------------------------------------------------------------
default['chruby']['version'] = '0.3.9'
default['chruby']['auto_switch'] = true
default['chruby']['rubies'] = { '2.1.5' => true, '2.0.0-p643' => true }
default['chruby']['default'] = '2.1.5'
# TODO: hashed versions?
default['netdevops']['package']['gem'] = %w( fog
                                             httparty
                                             junos-ez-stdlib
                                             junos-ez-srx
                                             netconf
                                             puppet
                                             rails
                                             rest
                                             serialport
                                             sinatra
                                             sloe )
default['chef_dk']['version'] = '0.4.0'

# -----------------------------------------------------------------------------
# Golang
# -----------------------------------------------------------------------------

# TODO: gvm cookbook
default['go']['version'] = '1.4.2'
default['go']['platform'] = 'amd64'
default['go']['scm'] = 'true'
default['go']['gopath'] = '/opt/go'
# TODO: add packages
# default['go']['packages'] = []
default['go']['owner'] = 'vagrant'
default['go']['group'] = 'vagrant'

# -----------------------------------------------------------------------------
# Python
# -----------------------------------------------------------------------------

default['pyenv']['user_installs'] = [
  {
    'user'     => 'vagrant',
    'pythons'  => ['2.7.9', '3.4.3'],
    'global'   => '2.7.9'
  }
]
default['pyenv']['git_ref'] = 'v20150226'
default['netdevops']['python']['version'] = '2.7.9'
# TODO: hashed versions?
default['netdevops']['package']['pip'] = %w( ansible
                                             click
                                             django
                                             flask
                                             salt )
default['netdevops']['package']['openstackpip'] = %w( python-glanceclient
                                                      python-heatclient
                                                      python-ironicclient
                                                      python-keystoneclient
                                                      python-neutronclient
                                                      python-openstackclient
                                                      python-novaclient
                                                      python-swiftclient )

# -----------------------------------------------------------------------------
# Misc.
# -----------------------------------------------------------------------------

default['netdevops']['hub']['url'] = 'https://github.com/github/hub/releases/download/v2.2.0/hub-linux-amd64-2.2.0.tar.gz'
default['netdevops']['hub']['version'] = '0.7.5'
default['netdevops']['hub']['sha256'] = 'ea6a3b639c8d6054c27c9ad71ff3e9a074da67dad2d74e0e8f0feba7f39d223e'
