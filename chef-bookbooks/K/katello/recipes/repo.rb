#
# Cookbook Name:: katello
# Recipe:: default
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

repo_file = "#{Chef::Config[:file_cache_path]}/#{File.basename(node['katello']['repo']['url'])}"

remote_file repo_file do
  source node['katello']['repo']['url']
  action :create
end

yum_package 'katello-repos' do
  source repo_file
  action :install
end

if platform_family?('rhel')
  include_recipe 'yum-epel'

  if platform?('centos')

    # Add the things normally found at http://repos.fedorapeople.org/repos/candlepin/subscription-manager/epel-subscription-manager.repo
    yum_repository 'epel-subscription-manager' do
      description 'Tools and libraries for Red Hat subscription management.'
      baseurl 'http://repos.fedorapeople.org/repos/candlepin/subscription-manager/epel-$releasever/$basearch/'
      gpgcheck false
      action :create
    end

    yum_repository 'epel-subscription-manager-source' do
      description 'Tools and libraries for Red Hat subscription management. - Source'
      baseurl 'http://repos.fedorapeople.org/repos/candlepin/subscription-manager/epel-$releasever/SRPMS'
      gpgcheck false
      enabled false
      action :create
    end
  end
end
