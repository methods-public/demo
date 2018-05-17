#
# Copyright (c) 2017 Make.org
#
# Licensed under the Apache License, Version 2.0 (the "License")
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

mount_attrs = node[cookbook_name]['backup']['mount']
service_name = node.run_state['ovh_service_name']
hostname = node.run_state['backup_hostname']

unless hostname.nil? || service_name.nil?
  mount_attrs.each_pair do |proto, config|
    next unless node[cookbook_name]['backup']['protos'][proto]

    package config['packages'][node['platform']]

    directory config['mount_point'] do
      owner config['owner']
      group config['group']
      recursive true
      mode '0750'
    end

    device_str =
      case proto
      when 'nfs' then "#{hostname}:#{config['server_path']}/#{service_name}"
      when 'cifs' then "//#{hostname}/#{service_name}"
      end

    mount config['mount_point'] do
      device device_str
      fstype proto
      options config['options']
      retries node[cookbook_name]['backup']['mount_retries']
      retry_delay node[cookbook_name]['backup']['mount_delay']
    end
  end
end
