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

# Monkey patches for docker cookbook to fix bugs

# ip_address is not returned correctly, causing the resource to run each time
module ::DockerCookbook # rubocop:disable Style/ClassAndModuleChildren
  # patch DockerContainer
  class DockerContainer < DockerBase
    alias load_current_value_official load_current_value!
    def load_current_value! # rubocop:disable Metrics/AbcSize
      load_current_value_official
      unless ip_address.nil?
        m = "#{cookbook_name}: monkey patch on ip_address is no longer needed!"
        Log.warn(m)
        return
      end
      # IP is not included in container, probably a bug of docker-api
      # workaround: use 'docker inspect' with cli
      output = shell_out!("docker inspect #{container.id}").stdout
      clic = JSON.parse(output).first
      ip = clic.dig('NetworkSettings', 'Networks', network_mode, 'IPAddress')
      ip_address(ip.to_s)
    end
  end
end

# Run docker resources from attributes
config = node['docker-platform'].to_h

resource_types = config.select { |key| key.start_with? 'docker_' }
resource_types.each_pair do |type, resources|
  resources.each_pair do |name, resource_conf|
    resource = send(type.to_sym, name)
    (resource_conf || {}).each_pair do |key, value|
      value = [value] unless value.is_a? Array
      resource.send(key, *value)
    end
  end
end
