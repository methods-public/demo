#
# Cookbook Name:: coopr
# Recipe:: repo
#
# Copyright © 2013-2017 Cask Data, Inc.
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
when 'debian'
  include_recipe 'apt'
  apt_repository 'coopr' do
    uri node['coopr']['repo']['apt_repo_url']
    distribution node['lsb']['codename']
    components node['coopr']['repo']['apt_components']
    action :add
    arch 'amd64'
    key "#{node['coopr']['repo']['apt_repo_url']}/pubkey.gpg"
  end
when 'rhel', 'amazon' # ~FC024
  include_recipe 'yum'
  yum_repository 'coopr' do
    description 'Coopr YUM repository'
    url node['coopr']['repo']['yum_repo_url']
    gpgkey "#{node['coopr']['repo']['yum_repo_url']}/pubkey.gpg"
    gpgcheck true
    action :add
  end
end
