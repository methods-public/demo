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

# Create swarm services, only on leader to avoid conflict
(node[cookbook_name]['services'] || {}).each_pair do |name, conf|
  resource = docker_platform_service(name) do
    only_if 'docker node ls --format "{{.Hostname}}:{{.ManagerStatus}}" | \
      grep "^$(hostname):Leader\$"'
  end
  conf.each_pair { |key, value| resource.send(key, value) }
end
