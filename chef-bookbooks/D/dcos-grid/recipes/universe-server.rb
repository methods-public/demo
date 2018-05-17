#
# Cookbook Name:: dcos-grid
# Recipe:: universe-server
#
# Copyright 2016, whitestar
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

doc_url = 'https://docs.docker.com/registry/deploying/#/managing-with-compose'

include_recipe 'docker-grid::compose'

app_dir = node['dcos-grid']['universe-server']['docker-compose']['app_dir']
[
  app_dir,
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

[
  'docker-compose.yml',
].each {|conf_file|
  template "#{app_dir}/#{conf_file}" do
    source  "opt/docker-compose/app/dcos-universe/#{conf_file}"
    owner 'root'
    group 'root'
    mode '0644'
  end
}

log <<-"EOM"
Note: You must execute the following command manually.
  See #{doc_url}
  - Start:
    $ cd #{app_dir}
    $ docker-compose up -d
  - Stop
    $ docker-compose down
EOM
