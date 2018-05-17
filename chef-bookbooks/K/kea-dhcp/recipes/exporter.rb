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

# Initialize configuration
include_recipe "#{cookbook_name}::init"
config = node.run_state[cookbook_name]['config']

# Create DHCP client exporter script and metrics directory
[
  config['exporter']['install_dir'],
  config['exporter']['metrics_dir']
].uniq.each do |dir_path|
  directory "kea-dhcp::#{dir_path}" do
    path dir_path
    recursive true
    mode '0755'
  end
end

# Copy DHCP client exporter script
exporter_file = "#{config['exporter']['install_dir']}/dhcp-client_exporter.sh"

cookbook_file exporter_file.to_s do
  source 'dhcp-client_exporter.sh'
  mode '0755'
  action :create
end

# Configure DHCP client exporter systemd unit
metrics_file = "#{config['exporter']['metrics_dir']}/dhcp-client.prom"
network_interfaces = config['network-interface']
                     .select { |v| v['bootproto'].start_with?('dhcp') }
                     .map { |v| v['device'] }
                     .join(' ')

# Retrieve dynamically assigned network interfaces
systemd_unit = config['exporter']['unit'].to_h
systemd_unit['Service']['ExecStart'] =
  "/bin/bash -c '#{exporter_file} #{network_interfaces} > #{metrics_file}'"

systemd_unit 'dhcp-client-exporter.service' do
  content systemd_unit
  action %i[create]
end

# start/enable or disable/stop depending if there is some dhcp ifaces
actions = %i[create enable start]
actions = %i[create disable stop] if network_interfaces.empty?
# Configure DHCP client exporter systemd timer unit
systemd_unit 'dhcp-client-exporter.timer' do
  content config['exporter']['timer_unit']
  action actions
end
