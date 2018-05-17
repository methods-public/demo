#
# Cookbook Name:: auditbeat
# Recipe:: package
#
# Copyright 2017, Virender Khatri
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

version_string = node['platform_family'] == 'rhel' ? "#{node['auditbeat']['version']}-#{node['auditbeat']['release']}" : node['auditbeat']['version']

case node['platform_family']
when 'debian'
  package 'apt-transport-https'

  if node['auditbeat']['setup_repo']
    # apt repository configuration
    apt_repository 'beats' do
      uri node['auditbeat']['apt']['uri']
      components node['auditbeat']['apt']['components']
      key node['auditbeat']['apt']['key']
      distribution node['auditbeat']['apt']['distribution']
      action node['auditbeat']['apt']['action']
    end

    unless node['auditbeat']['ignore_version'] # ~FC023
      apt_preference 'auditbeat' do
        pin          "version #{node['auditbeat']['version']}"
        pin_priority '700'
      end
    end
  end

when 'rhel'
  if node['auditbeat']['setup_repo']
    # yum repository configuration
    yum_repository 'beats' do
      description node['auditbeat']['yum']['description']
      baseurl node['auditbeat']['yum']['baseurl']
      gpgcheck node['auditbeat']['yum']['gpgcheck']
      gpgkey node['auditbeat']['yum']['gpgkey']
      enabled node['auditbeat']['yum']['enabled']
      metadata_expire node['auditbeat']['yum']['metadata_expire']
      action node['auditbeat']['yum']['action']
    end

    unless node['auditbeat']['ignore_version'] # ~FC023
      yum_version_lock 'auditbeat' do
        version node['auditbeat']['version']
        release node['auditbeat']['release']
        action :update
      end
    end
  end
end

package 'auditbeat' do # ~FC009
  version version_string unless node['auditbeat']['ignore_version']
  options node['auditbeat']['apt']['options'] if node['auditbeat']['apt']['options'] && node['platform_family'] == 'debian'
  notifies :restart, "service[#{node['auditbeat']['service']['name']}]" if node['auditbeat']['notify_restart'] && !node['auditbeat']['disable_service']
  flush_cache(:before => true) if node['platform_family'] == 'rhel'
  allow_downgrade true if node['platform_family'] == 'rhel'
end
