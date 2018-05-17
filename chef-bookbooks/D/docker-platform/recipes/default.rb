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

# Install and configure docker images
include_recipe "#{cookbook_name}::repository"
include_recipe "#{cookbook_name}::package"
include_recipe "#{cookbook_name}::tls"
include_recipe "#{cookbook_name}::config"
include_recipe "#{cookbook_name}::service"
include_recipe "#{cookbook_name}::swarm"
include_recipe "#{cookbook_name}::docker"
include_recipe "#{cookbook_name}::login"
include_recipe "#{cookbook_name}::swarm_services"
