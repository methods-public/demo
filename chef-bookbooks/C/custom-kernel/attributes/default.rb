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

cookbook_name = 'custom-kernel'

# If your kernel is build by gitlab-ci, just change version, project & build_id
# If not, override kernel_rpm, headers_rpm and base_url
default[cookbook_name]['version'] = '4.9.62'
default[cookbook_name]['project'] = 'https://gitlab.com/sre-tools/kernel'
default[cookbook_name]['build_id'] = '40654543'

version = node[cookbook_name]['version']
project = node[cookbook_name]['project']
build_id = node[cookbook_name]['build_id']
arch = node['kernel']['machine']

default[cookbook_name]['kernel_rpm'] =
  "kernel-#{version}-#{build_id}.#{arch}.rpm"
default[cookbook_name]['kernel_checksum'] = # package is not install if empty
  'f864d0030683232d722ff0db401ea65423d984af3df6c908457bfa9bd79628f5'

default[cookbook_name]['headers_rpm'] =
  "kernel-headers-#{version}-#{build_id}.#{arch}.rpm"
default[cookbook_name]['headers_checksum'] = # package is not install if empty
  'd8cd5e917da5923014b668dcc79d1bacbd84c3cc40185a717ad7965dd8d02a87'

default[cookbook_name]['base_url'] =
  "#{project}/-/jobs/#{build_id}/artifacts/raw/#{arch}"

# When to reboot, now (:reboot_now), at the end of the run (:request_reboot)
# or even never (:nothing)
default[cookbook_name]['reboot_action'] = :reboot_now
