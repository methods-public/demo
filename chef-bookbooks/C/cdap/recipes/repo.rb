#
# Cookbook Name:: cdap
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

maj_min = node['cdap']['version'].to_f

case node['platform_family']
when 'debian'
  include_recipe 'apt'
  codename = node['lsb']['codename']
  case codename
  when 'raring', 'saucy', 'trusty', 'utopic', 'vivid', 'wily', 'xenial', 'wheezy', 'jessie', 'stretch'
    codename = 'precise'
    Chef::Log.warn('Overriding repository distribution to Precise')
  end
  apt_repository "cdap-#{maj_min}" do
    uri node['cdap']['repo']['apt_repo_url']
    distribution codename
    components node['cdap']['repo']['apt_components']
    action :add
    arch 'amd64'
    key "#{node['cdap']['repo']['apt_repo_url']}/pubkey.gpg"
  end
  file '/etc/apt/sources.list.d/cask.list' do
    action :delete
  end
when 'rhel', 'amazon' # ~FC024
  yum_repository "cdap-#{maj_min}" do
    description 'CDAP YUM repository'
    url node['cdap']['repo']['yum_repo_url']
    gpgkey "#{node['cdap']['repo']['yum_repo_url']}/pubkey.gpg"
    gpgcheck true
    action :add
  end
  file '/etc/yum.repos.d/cask.repo' do
    action :delete
  end
end
