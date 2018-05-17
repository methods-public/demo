#
# Cookbook Name:: nexus-grid
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

default['nexus-grid']['with_ssl_cert_cookbook'] = false
# If ['nexus-grid']['with_ssl_cert_cookbook'] is true,
# node['nexus-grid']['docker-compose']['config']
# are overridden by the following 'common_name' attributes.
default['nexus-grid']['ssl_cert']['common_name'] = node['fqdn']

default['nexus-grid']['docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/nexus"
default['nexus-grid']['docker-compose']['etc_dir'] = "#{node['nexus-grid']['docker-compose']['app_dir']}/etc"
default['nexus-grid']['docker-compose']['data_dir'] = "#{node['nexus-grid']['docker-compose']['app_dir']}/data"

force_override['nexus-grid']['docker-compose']['config_format_version'] = '2'
version_2_config = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    'reverseproxy' => {
      'depends_on' => [
        'nexus',
      ],
      'restart' => 'always',
      'image' => 'nginx:alpine',
      'expose' => [
        '8081',
      ],
      'ports' => [
        #'8081:8081',  # default
      ],
      'volumes' => [
        # This volume will be set by the nexus-grid::docker-compose recipe automatically.
        #"#{node['nexus-grid']['docker-compose']['etc_dir']}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro",
      ],
    },
    'nexus' => {
      'restart' => 'always',
      #'image' => 'sonatype/nexus',  # Nexus2
      'image' => 'sonatype/nexus3',
      'ports' => [
        # Do not expose!
        #'8081:8081',
        #'8443:8443',
      ],
      'volumes' => [
        # This volume will be set by the nexus-grid::docker-compose recipe automatically.
        # * Nexus3
        #"#{node['nexus-grid']['docker-compose']['data_dir']}:/nexus-data:rw",
        # * Nexus2
        #"#{node['nexus-grid']['docker-compose']['data_dir']}:/sonatype-work:rw",
      ],
      'environment' => {
        # * Nexus3
        #'JAVA_MAX_HEAP' => '1200m',  # passed as -Xmx. Defaults to 1200m.
        #'JAVA_MIN_HEAP' => '1200m',  # passed as -Xms. Defaults to 1200m.
        #'EXTRA_JAVA_OPTS' => '',  # Additional options can be passed to the JVM via this variable.
        # * Nexus2
        #'CONTEXT_PATH' => '/nexus',
        #'MAX_HEAP' => '768m',
        #'MIN_HEAP' => '256m',
        #'JAVA_OPTS' => '-server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true',
        #'LAUNCHER_CONF' => './conf/jetty.xml ./conf/jetty-requestlog.xml',
      },
    },
  },
}

default['nexus-grid']['docker-compose']['config'] = version_2_config
