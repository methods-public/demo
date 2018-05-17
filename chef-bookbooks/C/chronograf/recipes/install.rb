#
# Cookbook Name:: chronograf
# Recipe:: install
#
# Copyright 2015, Virender Khatri
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

case node['platform_family']
when 'debian'
  package 'apt-transport-https'

  if node['chronograf']['setup_repository']
    apt_repository 'influxdb' do
      uri node['chronograf']['apt']['uri']
      components node['chronograf']['apt']['components']
      key node['chronograf']['apt']['key']
      distribution node['chronograf']['apt']['distribution']
      action node['chronograf']['apt']['action']
    end

    unless node['chronograf']['ignore_version'] # ~FC023
      apt_preference 'chronograf' do
        pin          "version #{node['chronograf']['version']}"
        pin_priority '700'
      end
    end
  end
when 'rhel', 'amazon'
  if node['chronograf']['setup_repository']
    yum_repository 'influxdb' do
      description node['chronograf']['yum']['description']
      baseurl node['chronograf']['yum']['baseurl']
      gpgcheck node['chronograf']['yum']['gpgcheck']
      gpgkey node['chronograf']['yum']['gpgkey']
      enabled node['chronograf']['yum']['enabled']
      action node['chronograf']['yum']['action']
    end

    unless node['chronograf']['ignore_version'] # ~FC023
      yum_version_lock 'chronograf' do
        version node['chronograf']['version']
        release node['chronograf']['release']
        action :update
      end
    end
  end
end

package 'chronograf' do
  version if node['chronograf']['version']
  notifies :restart, 'service[chronograf]' if node['chronograf']['notify_restart'] && !node['chronograf']['disable_service']
end
