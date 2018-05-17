#
# Cookbook Name:: gitlab-grid
# Recipe:: docker-compose
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

doc_url = 'https://docs.gitlab.com/omnibus/docker/README.html'

include_recipe 'docker-grid::compose'
include_recipe 'gitlab-grid::commons'

#gitlab_rb = node['gitlab-grid']['gitlab.rb']
#override_gitlab_rb = node.override['gitlab-grid']['gitlab.rb']
force_override_gitlab_rb = node.force_override['gitlab-grid']['gitlab.rb']

config = node['gitlab-grid']['docker-compose']['config']
override_config = node.override['gitlab-grid']['docker-compose']['config']
force_override_config = node.force_override['gitlab-grid']['docker-compose']['config']

app_dir = node['gitlab-grid']['docker-compose']['app_dir']
etc_dir = node['gitlab-grid']['docker-compose']['etc_dir']
logs_dir = node['gitlab-grid']['docker-compose']['logs_dir']
data_dir = node['gitlab-grid']['docker-compose']['data_dir']

envs = {}
vols = config['services']['gitlab']['volumes'].to_a

if node['gitlab-grid']['with_ssl_cert_cookbook']
  include_recipe 'ssl_cert::server_key_pairs'

  # GitLab
  # These paths are already set in the `gitlab-grid::commons` recipe.
  cert_path = force_override_gitlab_rb['nginx']['ssl_certificate']
  key_path = force_override_gitlab_rb['nginx']['ssl_certificate_key']

  vols.push("#{cert_path}:/etc/gitlab/server.crt:ro")
  vols.push("#{key_path}:/etc/gitlab/server.key:ro")
  force_override_gitlab_rb['nginx']['ssl_certificate'] = '/etc/gitlab/server.crt'
  force_override_gitlab_rb['nginx']['ssl_certificate_key'] = '/etc/gitlab/server.key'

  # GitLab Container Registry
  # These paths are already set in the `gitlab-grid::commons` recipe.
  reg_cert_path = force_override_gitlab_rb['registry_nginx']['ssl_certificate']
  reg_key_path = force_override_gitlab_rb['registry_nginx']['ssl_certificate_key']

  unless reg_cert_path.nil?
    vols.push("#{reg_cert_path}:/etc/gitlab/reg_server.crt:ro")
    force_override_gitlab_rb['registry_nginx']['ssl_certificate'] = '/etc/gitlab/reg_server.crt'
  end
  unless reg_key_path.nil?
    vols.push("#{reg_key_path}:/etc/gitlab/reg_server.key:ro")
    force_override_gitlab_rb['registry_nginx']['ssl_certificate_key'] = '/etc/gitlab/reg_server.key'
  end
end

[
  app_dir,
  data_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

[
  etc_dir,
  logs_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    #owner 'root'
    group 'root'
    #mode '0755'
    recursive true
  end
}

if config['services']['gitlab']['ports'].empty?
  override_config['services']['gitlab']['ports'] = [
    '80:80',
    '443:443',
    '22:22',
  ]
end

force_override_config['services']['gitlab']['environment'] = envs unless envs.empty?
override_config['services']['gitlab']['volumes'] = vols unless vols.empty?

template "#{etc_dir}/gitlab.rb" do
  source  'etc/gitlab/gitlab.rb'
  owner 'root'
  group 'root'
  mode '0644'
end

[
  'docker-compose.yml',
].each {|conf_file|
  template "#{app_dir}/#{conf_file}" do
    source  "opt/docker-compose/app/gitlab/#{conf_file}"
    owner 'root'
    group 'root'
    mode '0644'
  end
}

log <<-"EOM"
Note: You must execute the following command manually.
  See #{doc_url}
  * Start:
    $ cd #{app_dir}
    $ docker-compose up -d
  * Stop
    $ docker-compose down
EOM
