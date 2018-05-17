#
# Cookbook Name:: elastic-heartbeat
# Recipe:: install
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

version_string = %w[rhel amazon fedora].include?(node['platform_family']) ? "#{node['heartbeat']['version']}-#{node['heartbeat']['release']}" : node['heartbeat']['version']

case node['platform_family']
when 'debian'
  include_recipe 'elastic_beats_repo::apt' if node['heartbeat']['setup_repo']

  unless node['heartbeat']['ignore_version'] # ~FC023
    apt_preference node['heartbeat']['package_name'] do
      pin          "version #{node['heartbeat']['version']}"
      pin_priority '700'
    end
  end
when 'fedora', 'rhel', 'amazon'
  include_recipe 'elastic_beats_repo::yum' if node['heartbeat']['setup_repo']
  include_recipe 'yum-plugin-versionlock::default'

  unless node['heartbeat']['ignore_version'] # ~FC023
    yum_version_lock node['heartbeat']['package_name'] do
      version node['heartbeat']['version']
      release node['heartbeat']['release']
      action :update
    end
  end
end

package node['heartbeat']['package_name'] do # ~FC009
  version version_string unless node['heartbeat']['ignore_version']
  options node['heartbeat']['apt']['options'] if node['heartbeat']['apt']['options'] && node['platform_family'] == 'debian'
  notifies :restart, 'service[heartbeat]' if node['heartbeat']['notify_restart'] && !node['heartbeat']['disable_service']
  flush_cache(:before => true) if node['platform_family'] == 'rhel'
  allow_downgrade true if node['platform_family'] == 'rhel'
end
