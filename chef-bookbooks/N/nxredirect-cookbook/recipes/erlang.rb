#
# Copyright (c) 2016 Sam4Mobile, 2017 Make.org
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

package_retries = node[cookbook_name]['package_retries']

remote_file "#{Chef::Config[:file_cache_path]}/erlang-solutions.rpm" do
  source node[cookbook_name]['erlang-solutions']
end

package node[cookbook_name]['wget'] do
  retries package_retries unless package_retries.nil?
  not_if { node[cookbook_name]['wget'].nil? }
end

rpm_package 'erlang-solutions' do
  source "#{Chef::Config[:file_cache_path]}/erlang-solutions.rpm"
  retries package_retries unless package_retries.nil?
end

package node[cookbook_name]['erlang'] do
  version node[cookbook_name]['erlang_version']
  retries package_retries unless package_retries.nil?
  not_if { node[cookbook_name]['erlang'].nil? }
  action :upgrade if node[cookbook_name]['erlang_version'] == 'latest'
end
