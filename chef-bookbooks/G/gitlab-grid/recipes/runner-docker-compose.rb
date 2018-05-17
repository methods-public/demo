#
# Cookbook Name:: gitlab-grid
# Recipe:: runner-docker-compose
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

doc_url = 'https://github.com/ayufan/gitlab-ci-multi-runner/blob/master/docs/install/docker.md'

include_recipe 'docker-grid::compose'
#include_recipe 'gitlab-grid::commons'

config = node['gitlab-grid']['runner-docker-compose']['config']
override_config = node.override['gitlab-grid']['runner-docker-compose']['config']
#force_override_config = node.force_override['gitlab-grid']['runner-docker-compose']['config']
app_dir = node['gitlab-grid']['runner-docker-compose']['app_dir']
etc_dir = node['gitlab-grid']['runner-docker-compose']['etc_dir']
certs_dir = "#{etc_dir}/certs"

#envs = {}
vols = config['services']['runner']['volumes'].to_a

[
  app_dir,
  etc_dir,
  certs_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

vols.push("#{etc_dir}:/etc/gitlab-runner")

if node['gitlab-grid']['with_ssl_cert_cookbook'] && node['gitlab-grid']['runner-docker-compose']['import_ca']
  ::Chef::Recipe.send(:include, SSLCert::Helper)
  ca_name = node['gitlab-grid']['ssl_cert']['ca_name']
  append_ca_name(ca_name)
  include_recipe 'ssl_cert::ca_certs'
  vols.push("#{ca_cert_path(ca_name)}:/etc/gitlab-runner/certs/ca.crt:ro")
end

override_config['services']['runner']['volumes'] = vols unless vols.empty?

[
  'docker-compose.yml',
].each {|conf_file|
  template "#{app_dir}/#{conf_file}" do
    source  "opt/docker-compose/app/gitlab-runner/#{conf_file}"
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
    $ docker exec -it #{config['services']['runner']['container_name']} gitlab-runner register
  * Stop
    $ docker-compose down
EOM
