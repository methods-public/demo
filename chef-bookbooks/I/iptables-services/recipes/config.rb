#
# Copyright (c) 2017-2018 Make.org
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

path = node[cookbook_name]['config_path']

node[cookbook_name]['services'].each_pair do |service, active|
  next unless active

  config = node[cookbook_name][service]['config']
  str_config = config.map { |key, value| "#{key}=\"#{value}\"" }.join("\n")

  file "#{path}/#{service}#{node[cookbook_name]['config_suffix']}" do
    content "#{str_config}\n"
    mode '0600'
  end
end
