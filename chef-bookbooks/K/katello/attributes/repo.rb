#
# Cookbook Name:: katello
# Attributes:: repo
#
# Copyright (C) 2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'fedora'
  case node['platform_version'].to_i
  when 19
    default['katello']['repo']['url'] = 'http://fedorapeople.org/groups/katello/releases/yum/1.4/Fedora/19/x86_64/katello-repos-1.4.4-1.fc19.noarch.rpm'
  end
when 'rhel'
  default['katello']['repo']['url'] = 'http://fedorapeople.org/groups/katello/releases/yum/1.4/RHEL/6Server/x86_64/katello-repos-1.4.4-1.el6.noarch.rpm'
end
