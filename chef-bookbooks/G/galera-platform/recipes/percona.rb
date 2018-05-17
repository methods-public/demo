#
# Copyright (c) 2016 Sam4Mobile
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

# We need to install percona xtrabackup software if sst method
# is set to xtrabackup
yum_repository 'Percona' do
  description 'Percona repository'
  baseurl node['galera-platform']['percona']['repo_url']
  gpgkey node['galera-platform']['percona']['repo_gpgkey']
  gpgcheck true
  action :create
end

# Socat is needed for SST transfers
package 'socat' do
  retries node['galera-platform']['package_retries']
end
# Install Percona xtrabackup
package node['galera-platform']['percona']['xtrabackup']['package'] do
  retries node['galera-platform']['package_retries']
end
