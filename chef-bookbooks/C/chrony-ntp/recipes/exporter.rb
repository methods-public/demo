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

# Create chrony exporter script and metrics directory
[
  node[cookbook_name]['exporter']['install_dir'],
  node[cookbook_name]['exporter']['metrics_dir']
].uniq.each do |dir_path|
  directory "chrony-ntp::#{dir_path}" do
    path dir_path
    recursive true
    mode '0755'
  end
end
# Copy chrony exporter script
file = "#{node[cookbook_name]['exporter']['install_dir']}/chrony_exporter.sh"
cookbook_file file do
  source 'chrony_exporter.sh'
  mode '0755'
  action :create
end

# Configure exporter systemd unit
systemd_unit 'chronyd-exporter.service' do
  enabled true
  active false
  masked false
  static false
  content node[cookbook_name]['exporter']['unit']
  triggers_reload true
  action %i[create enable]
end

# Configure exporter systemd timer unit
systemd_unit 'chronyd-exporter.timer' do
  enabled true
  active true
  masked false
  static false
  content node[cookbook_name]['exporter']['timer_unit']
  triggers_reload true
  action %i[create enable start]
end
