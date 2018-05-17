#
# Cookbook Name:: gitlab-grid
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

default['gitlab-grid']['with_ssl_cert_cookbook'] = false
# If ['gitlab-grid']['with_ssl_cert_cookbook'] is true,
# node['gitlab-grid']['gitlab.rb'] are overridden by the following 'common_name' attributes.
default['gitlab-grid']['ssl_cert']['ca_name'] = nil
default['gitlab-grid']['ssl_cert']['common_name'] = node['fqdn']
default['gitlab-grid']['ssl_cert']['registry'] = {
  # Container Registry
  'reuse_gitlab_common_name' => false,
  'common_name' => nil,
}
default['gitlab-grid']['gitlab.rb'] = {
  'external_url' => "http://#{node['fqdn']}",
  #'registry_external_url' => "https://#{node['fqdn']}:5000",
  'gitlab_rails' => {
    'time_zone' => 'UTC',
  },
  'nginx' => {
    'redirect_http_to_https' => false,
  },
}
default['gitlab-grid']['gitlab.rb_extra_config_str'] = nil
default['gitlab-grid']['docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/gitlab"
default['gitlab-grid']['docker-compose']['etc_dir'] = "#{node['gitlab-grid']['docker-compose']['app_dir']}/etc"
default['gitlab-grid']['docker-compose']['logs_dir'] = "#{node['gitlab-grid']['docker-compose']['app_dir']}/logs"
default['gitlab-grid']['docker-compose']['data_dir'] = "#{node['gitlab-grid']['docker-compose']['app_dir']}/data"
default['gitlab-grid']['docker-compose']['config'] = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    'gitlab' => {
      'image' => 'gitlab/gitlab-ce:latest',
      'restart' => 'always',
      'hostname' => node['fqdn'],
      'environment' => {
=begin
        # Do not use this variable, instead use the `['gitlab-grid']['gitlab.rb']` attribute.
        'GITLAB_OMNIBUS_CONFIG' => <<-EOS,
external_url 'http://gitlab.io.example.com'
# Add any other gitlab.rb configuration here, each on its own line
        EOS
=end
      },
      'ports' => [
        #'80:80',
        #'443:443',
        #'22:22',
      ],
      'volumes' => [
        "#{node['gitlab-grid']['docker-compose']['etc_dir']}:/etc/gitlab",
        "#{node['gitlab-grid']['docker-compose']['logs_dir']}:/var/log/gitlab",
        "#{node['gitlab-grid']['docker-compose']['data_dir']}:/var/opt/gitlab",
      ],
    },
  },
}

default['gitlab-grid']['runner-docker-compose']['import_ca'] = false
default['gitlab-grid']['runner-docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/gitlab-runner"
default['gitlab-grid']['runner-docker-compose']['etc_dir'] = "#{node['gitlab-grid']['runner-docker-compose']['app_dir']}/etc"
default['gitlab-grid']['runner-docker-compose']['config'] = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    'runner' => {
      'container_name' => 'gitlab-runner',
      'image' => 'gitlab/gitlab-runner:latest',
      'restart' => 'always',
      #'environment' => {
      #},
      'volumes' => [
        #"#{node['gitlab-grid']['runner-docker-compose']['etc_dir']}:/etc/gitlab-runner",
        #'/var/run/docker.sock:/var/run/docker.sock',
      ],
    },
  },
}
