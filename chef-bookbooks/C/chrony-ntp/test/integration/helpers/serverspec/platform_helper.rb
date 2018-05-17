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

def get_platform_specific(platform)
  platform_specific = {}
  case platform
  when 'redhat'
    platform_specific['config_file'] = '/etc/chrony.conf'
    platform_specific['service'] = 'chronyd'
  when 'debian'
    platform_specific['config_file'] = '/etc/chrony/chrony.conf'
    platform_specific['service'] = 'chrony'
  end
  platform_specific
end
