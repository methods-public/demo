#
# Cookbook Name:: docker-grid
# Recipe:: dind-compose
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

doc_url = 'https://hub.docker.com/r/library/docker/'

include_recipe 'docker-grid::compose'

app_dir = node['docker-grid']['dind-compose']['app_dir']
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

config_srvs = node['docker-grid']['dind-compose']['config']['services']
override_config_srvs = node.override['docker-grid']['dind-compose']['config']['services']
#force_override_config_srvs = node.force_override['docker-grid']['dind-compose']['config']['services']

command = config_srvs['dind']['command'].to_a
vols = config_srvs['dind']['volumes'].to_a

data_dir = node['docker-grid']['dind-compose']['data_dir']
if !data_dir.nil? && !data_dir.empty?
  directory data_dir do
    owner 'root'
    group 'root'
    mode '0711'
    recursive true
  end

  vols.push("#{data_dir}:/var/lib/docker")
end

result = shell_out("docker info | grep 'Storage Driver: ' | awk -F': ' '{print $2}'")
if result.exitstatus.zero? && !result.stdout.chomp.empty? \
  && command.none? {|cmd| cmd =~ /^--storage-driver=.+/ }
  command.push("--storage-driver=#{result.stdout.chomp}")
end

# reset vlumes array.
override_config_srvs['dind']['command'] = command unless command.empty?
override_config_srvs['dind']['volumes'] = vols unless vols.empty?

[
  'docker-compose.yml',
].each {|conf_file|
  template "#{app_dir}/#{conf_file}" do
    source  "opt/docker-compose/app/docker-in-docker/#{conf_file}"
    owner 'root'
    group 'root'
    mode '0644'
  end
}

log 'dind-compose post install message' do
  message <<-"EOM"
Note: You must execute the following command manually.
    See #{doc_url}
    * Start:
      $ cd #{app_dir}
      $ docker-compose up -d
    * Stop
      $ docker-compose down
EOM
end
