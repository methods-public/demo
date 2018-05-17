#
# Cookbook Name:: athenz
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

force_override['athenz']['with_ssl_cert_cookbook'] = false
# If ['athenz']['with_ssl_cert_cookbook'] is true,
# node['athenz']['docker-compose']['config']
# are overridden by the following 'common_name' attributes.
default['athenz']['ssl_cert']['common_name'] = node['fqdn']

default['athenz']['docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/athenz"

force_override['athenz']['docker-compose']['config_format_version'] = '2'
version_2_config = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    'athenz' => {
      'restart' => 'always',
      'image' => 'athenz/athenz:v1.7.12',  # NG: its image fails to start in the version 1.7.20 or later.
      'hostname' => node['fqdn'],
      'ports' => [
        # defaults
        #'4443:4443',  # ZMS
        #'8443:8443',  # ZTS
        #'9443:9443',  # UI
      ],
      'volumes' => [
      ],
      'environment' => {
        'ZMS_SERVER' => node['fqdn'],
        'UI_SERVER' => node['fqdn'],
      },
    },
  },
}

default['athenz']['docker-compose']['config'] = version_2_config
