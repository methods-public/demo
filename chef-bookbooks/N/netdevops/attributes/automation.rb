#
# Cookbook Name:: netdevops
# Atributes:: automation
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

# hashicorp tools - all binaries, except for Vagrant (handled at distro-specific packaging)
default['netdevops']['hashicorp']['tools'] = %w( consul packer serf terraform )
default['netdevops']['consul']['url'] = 'https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip'
default['netdevops']['consul']['version'] = '0.5.0'
default['netdevops']['consul']['sha256'] = '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088'
default['netdevops']['packer']['url'] = 'https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip'
default['netdevops']['packer']['version'] = '0.7.5'
default['netdevops']['packer']['sha256'] = '8fab291c8cc988bd0004195677924ab6846aee5800b6c8696d71d33456701ef6'
default['netdevops']['serf']['url'] = 'https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip'
default['netdevops']['serf']['version'] = '0.6.4'
default['netdevops']['serf']['sha256'] = 'bdb2a60a37fbb46c1a498bbb1354e34c1951e3c5df8003b95f9d4019c4e37663'
default['netdevops']['terraform']['url'] = 'https://dl.bintray.com/mitchellh/terraform/terraform_0.3.7_linux_amd64.zip'
default['netdevops']['terraform']['version'] = '0.3.7'
default['netdevops']['terraform']['sha256'] = 'b63b36d76d9ea31cb6971edf23899ceb7291800618177adf987b7660b486527b'
# vagrant url + hash found in distro-specific packaging
default['netdevops']['vagrant']['plugins'] = %w( vagrant-cachier vagrant-host-shell vagrant-junos )
