#
# Cookbook Name:: rancher-ng
# Provider:: rancher_ng_agent
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

require 'uri'

::Chef::Provider.send(:include, RancherNg::Helpers)

URL_REGEXP = /\A(http[s]?):\/\/([0-9a-z\-.]+):([0-9]+)\/([a-z0-9]+)\/([a-z]+)\/([A-Z0-9]+):([0-9]+):([a-zA-Z0-9]+)\z/

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

  labels = labels_uri(new_resource)

  init_agent(new_resource, labels)
end

def init_agent(new_resource, labels)
  docker_container title(new_resource) do
    image new_resource.image
    tag new_resource.version
    command new_resource.auth_url || node['rancher_ng']['agent']['auth_url']
    entrypoint '/run.sh'
    volumes ['/var/run/docker.sock:/var/run/docker.sock', new_resource.mount_point]
    env "CATTLE_AGENT_IP=#{node['ipaddress']}"
    env "CATTLE_HOST_LABELS=#{labels}" unless labels.empty?
    privileged new_resource.privileged
    autoremove new_resource.autoremove

    action :run
    not_if 'docker inspect rancher-agent'
  end

  debug_resource(new_resource,
                 %i[name image version autoremove privileged mount_point auth_url])
end

def rancher_delete(new_resource)
  docker_container title(new_resource) do
    action :delete
  end
end

def title(new_resource)
  "#{new_resource.name}-url-runner"
end

def labels_uri(new_resource)
  URI.encode_www_form(new_resource.labels)
end
