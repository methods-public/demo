#
# Copyright (c) 2016 Sam4Mobile
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

# Deploy systemd unit files
unit_path = node['spark-platform']['unit_path']

%w(master worker).each do |role|
  template "#{unit_path}/spark-#{role}.service" do
    source "systemd/spark-#{role}.service.erb"
    variables(
      user: node['spark-platform']['user'],
      group: node['spark-platform']['group'],
      prefix_root: node['spark-platform']['prefix_root'],
      master_url:  node.run_state['spark-platform']['master_url']
    )
    user 'root'
    group 'root'
    notifies :run, 'execute[spark-platform:reload-systemd]', :immediately
  end
end

# Reload systemd if changes in a service template file
execute 'spark-platform:reload-systemd' do
  command 'systemctl daemon-reload'
  action :nothing
end
