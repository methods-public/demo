#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
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

# Reason for this is that chef-docker cookbook keep auth data in memory,
# therefore, if we want to use docker manually, we need to write this down

data = { 'auths' => {} }

(node[cookbook_name]['docker_registry'] || []).each do |name, config|
  serveraddress = config['serveraddress'] || name
  auth_str = "#{config['username']}:#{config['password']}"

  data['auths'] = {
    serveraddress => {
      'auth' => Base64.strict_encode64(auth_str),
      'email' => config['email']
    }
  }
end

directory 'login:/root/.docker' do
  path '/root/.docker'
end

file "#{cookbook_name}:save login info" do
  path '/root/.docker/config.json'
  content "#{JSON.pretty_generate(data)}\n"
  mode '0600'
  action :create
end
