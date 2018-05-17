#
# Cookbook Name:: kvm
# Recipe:: guest
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 2012, Societe Publica.
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

## Use kvm-clock
# http://s19n.net/articles/2011/kvm_clock.html
# Disabling NTP is recommended when using kvm-clock
if node['os'] == 'linux' && node['kernel']['release'] >= '2.6.27'
  node.override['ntp']['ntpdate']['disable'] = false
  include_recipe 'ntp::disable'
  include_recipe 'ntp::ntpdate'
else
  include_recipe 'ntp'
end
