#
# Cookbook Name:: spinnaker
# Attributes:: default
#
# Copyright 2017, whitestar
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

default['spinnaker']['halyard-docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/halyard"
default['spinnaker']['halyard-docker-compose']['config_dir'] = "#{node['spinnaker']['halyard-docker-compose']['app_dir']}/.hal"

force_override['spinnaker']['halyard-docker-compose']['config_format_version'] = '2'
version_2_config = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    'halyard' => {
      'restart' => 'always',
      'image' => 'gcr.io/spinnaker-marketplace/halyard:stable',
      'ports' => [
        # default
        #'127.0.0.1:8064:8064',
      ],
      'volumes' => [
        # This volume will be set by the spinnaker::halyard-ddocker-compose recipe automatically.
        #"#{node['spinnaker']['halyard-docker-compose']['config_dir']}:/root/.hal:rw",
      ],
      'environment' => {
      },
    },
  },
}

default['spinnaker']['halyard-docker-compose']['config'] = version_2_config
