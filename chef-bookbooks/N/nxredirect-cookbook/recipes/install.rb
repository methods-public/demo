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

package node[cookbook_name]['unzip'] do
  retries package_retries unless package_retries.nil?
  not_if { node[cookbook_name]['unzip'].nil? }
end

url = node[cookbook_name]['url']
remote_file "#{Chef::Config[:file_cache_path]}/nxredirect.zip" do
  source url
end

execute 'unzip nxredirect' do
  command "unzip -p #{Chef::Config[:file_cache_path]}/nxredirect.zip \
              > #{node[cookbook_name]['bin']} && \
          chmod +x #{node[cookbook_name]['bin']}"
  creates node[cookbook_name]['bin']
end
