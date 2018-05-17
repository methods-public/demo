#
# Copyright (c) 2016-2017 Sam4Mobile
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

# Create nginx ssl certs dir
directory node[cookbook_name]['ssl_certs_dir'] do
  recursive true
  mode '0755'
end

node[cookbook_name]['ssl_configs'].each do |name, config|
  resource = certificate_manage name
  config.each do |attr, val|
    val = [val]
    resource.send(attr, *val)
  end
end
