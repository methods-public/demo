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

unless node[cookbook_name]['systemd_unit'].empty?
  unit = node[cookbook_name]['systemd_unit'].to_hash

  # Needed for any unit modification
  execute "#{cookbook_name}:daemon-reload" do
    command 'systemctl daemon-reload'
    action :nothing
  end

  # Used for full override and to get to_ini method
  unit_content = systemd_unit 'docker.service' do
    content unit
    action node[cookbook_name]['unit_full_override'] ? :create : :delete
  end.to_ini

  # Append lines with = with same line without value after =
  unit_content = unit_content.lines.map do |line|
    line =~ /^\w+.*=/ ? ["#{line.split('=').first}=\n", line] : line
  end.flatten.join

  path = "#{node[cookbook_name]['systemd_unit_path']}/docker.service.d"
  directory path

  file "#{path}/override.conf" do
    content unit_content
    notifies :run, "execute[#{cookbook_name}:daemon-reload]", :immediately
    action :delete if node[cookbook_name]['unit_full_override']
  end

end

service 'docker' do
  action %i[enable start]
end

execute 'wait for docker to launch' do
  command <<-BASH
    for i in $(seq 1 10); do
      if [ -e /var/run/docker.sock ]; then
        break
      else
        sleep 5
      fi
    done
    BASH
  subscribes :run, 'service[docker]', :immediately
  action :nothing
  not_if 'test -e /var/run/docker.sock'
end
