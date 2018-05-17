#
# Cookbook Name:: rancher-ng
# Provider:: rancher_ng_server
#
# Copyright (C) 2017 Alexander Merkulov
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

use_inline_resources

::Chef::Provider.send(:include, RancherNg::Helpers)

action :create do
  rancher_create(new_resource)

  new_resource.updated_by_last_action(true)
end

action :delete do
  rancher_delete(new_resource)

  new_resource.updated_by_last_action(true)
end

def rancher_create(new_resource)
  docker_image new_resource.image do
    tag new_resource.version
    action :pull
  end

  if external_db?(new_resource)
    container_with_external_db(new_resource)
  elsif db_container?(new_resource)
    new_resource.db_host = '172.17.0.1'
    new_resource.db_port = '3306'
    new_resource.db_user = 'cattle'
    new_resource.db_pass = 'cattle'
    new_resource.db_name = 'cattle'

    add_directory(new_resource)
    db_container(new_resource)
    container_with_external_db(new_resource)
  else
    add_directory(new_resource)
    container(new_resource)
  end

  debug_resource(new_resource,
                 %i[name image version detach restart_policy port
                    db_dir db_host db_port db_user db_pass db_name])
end

def rancher_delete(new_resource)
  docker_container new_resource.name do
    action :delete
  end
end

def container_with_external_db(new_resource)
  container(new_resource, gen_db_command(new_resource))
end

def container(new_resource, cmd = nil)
  docker_container new_resource.name do
    repo new_resource.image
    tag new_resource.version
    command cmd unless cmd.nil?
    port "#{new_resource.port || node['rancher_ng']['server']['port']}:8080"
    detach new_resource.detach
    container_name new_resource.name
    restart_policy new_resource.restart_policy
    volumes ["#{new_resource.db_dir}:/var/lib/mysql"] if cmd.nil?

    action :run
  end
end

def db_container(new_resource)
  docker_image new_resource.db_container do
    tag new_resource.db_container_version
    action :pull
  end

  docker_container "#{new_resource.name}-db" do
    repo new_resource.db_container
    tag new_resource.db_container_version
    port '3306:3306'
    detach true
    command new_resource.db_container_command
    env ['MYSQL_ROOT_PASSWORD=password', 'MYSQL_DATABASE=cattle',
         'MYSQL_USER=cattle', 'MYSQL_PASSWORD=cattle']
    container_name "#{new_resource.name}-db"
    restart_policy new_resource.restart_policy
    volumes ["#{new_resource.db_dir}:/var/lib/mysql"]

    action :run
  end
end

def add_directory(new_resource)
  return unless new_resource.db_dir

  directory new_resource.db_dir do
    mode '0755'
  end

  if db_container?(new_resource)
    add_directory_docker(new_resource)
  else
    add_directory_inner(new_resource)
  end
end

def add_directory_inner(new_resource)
  execute 'fix rancher db rights' do
    command "chown -R 102:105 #{new_resource.db_dir}"
    action :run
  end
end

def add_directory_docker(new_resource)
  execute 'fix docker db rights' do
    command "chown -R 999:999 #{new_resource.db_dir}"
    action :run
  end
end

def external_db?(new_resource)
  new_resource.external_db && valid_db_args?(new_resource)
end

def db_container?(new_resource)
  new_resource.db_container || false
end

def valid_db_args?(new_resource)
  [
    new_resource.db_host,
    new_resource.db_port,
    new_resource.db_user,
    new_resource.db_pass,
    new_resource.db_name
  ].all? { |val| !val.nil? }
end

def gen_db_command(new_resource)
  [
    "--db-host #{new_resource.db_host}",
    "--db-port #{new_resource.db_port}",
    "--db-user #{new_resource.db_user}",
    "--db-pass #{new_resource.db_pass}",
    "--db-name #{new_resource.db_name}"
  ].join(' ')
end
