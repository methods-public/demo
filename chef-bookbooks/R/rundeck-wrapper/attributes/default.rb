#
# Copyright (c) 2017 Make.org
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

cookbook_name = 'rundeck-wrapper'

# Encrypted data bag to manage realm users credentials
default[cookbook_name]['data_bag']['realm_users'] = 'rundeck_users'

# Only users belonging to theses groups will be created
default[cookbook_name]['whitelist'] = []

# Hash of roles for which nodes YAML files are generated
# respecting rundeck resource model :
# - key must be the role name
# - value must be remote user used by rundeck
# See .kitchen.yml for example
default[cookbook_name]['nodes_roles'] = {}

# Do no use java cookbook, use package directly
default['rundeck_server']['install_java'] = false
default[cookbook_name]['java'] = {
  'centos' => 'java-1.8.0-openjdk-headless'
}

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
