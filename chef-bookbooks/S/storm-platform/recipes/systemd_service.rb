#
# Copyright (c) 2015-2016 Sam4Mobile
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

# Install service file, reload systemd daemon if necessary
execute 'storm-platform:systemd-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

# Java is needed by Storm. We may install it with package
java_package = node['storm-platform']['java'][node['platform']]
package java_package unless java_package.to_s.empty?

if node['storm-platform']['auto_restart']
  config_files = [
    "#{node['storm-platform']['prefix_home']}/storm/conf/storm.yaml",
    "#{node['storm-platform']['prefix_home']}/storm/log4j2/cluster.xml",
    "#{node['storm-platform']['prefix_home']}/storm/log4j2/worker.xml"
  ].map do |path|
    "template[#{path}]"
  end
else config_files = []
end

# Which services?
iam_nimbus = node.run_state['storm-platform']['iam_nimbus']
nimbus_ha = node.run_state['storm-platform']['nimbus_ha']
app_list = %w(supervisor logviewer)
if iam_nimbus
  app_list = %w(nimbus logviewer ui)
  app_list << 'supervisor' if nimbus_ha
end

app_list.each do |app|
  template "#{node['storm-platform']['unit_path']}/storm-#{app}.service" do
    variables app: app
    mode '0644'
    source 'storm.service.erb'
    notifies :run, 'execute[storm-platform:systemd-reload]', :immediately
  end

  service "storm-#{app}" do
    supports status: true, restart: true
    action [:enable, :start]
    subscribes :restart, config_files, :delayed
  end
end
