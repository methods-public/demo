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

if node['platform_family'] == 'rhel'
  package_arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i686'
  package_family = 'rpm'
else
  package_arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : 'i386'
  package_family = 'deb'
end

package_url = node['auditbeat']['package_url'] == 'auto' ? "https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-#{node['auditbeat']['version']}-#{package_arch}.#{package_family}" : node['auditbeat']['package_url']
package_file = ::File.join(Chef::Config[:file_cache_path], ::File.basename(package_url))

package 'apt-transport-https' if node['platform_family'] == 'debian'

remote_file 'auditbeat_package_file' do
  path package_file
  source package_url
  not_if { ::File.exist?(package_file) }
end

package 'auditbeat' do
  source package_file
  provider Chef::Provider::Package::Dpkg if node['platform_family'] == 'debian'
end
