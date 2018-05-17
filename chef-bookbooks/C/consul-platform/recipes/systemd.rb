#
# Copyright (c) 2016-2017 Sam4Mobile, 2017 Make.org
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

# Return if servers have not been configured
return if node.run_state.dig(cookbook_name, 'hosts').nil?

# Construct command line options
options = node[cookbook_name]['cli_opts'].map do |key, opt|
  "-#{key.to_s.tr('_', '-')}#{" #{opt}" unless opt.nil?}"
end.join(' ')

# Configure systemd unit with options
unit = node[cookbook_name]['systemd_unit'].to_hash
bin = "#{node[cookbook_name]['prefix_home']}/consul/consul"
unit['Service']['ExecStart'] = "#{bin} agent #{options}"

systemd_unit 'consul.service' do
  enabled true
  active true
  masked false
  static false
  content unit
  triggers_reload true
  action %i[create enable start]
end
