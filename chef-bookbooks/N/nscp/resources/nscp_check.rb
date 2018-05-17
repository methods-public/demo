#
# Cookbook Name:: nscp
# Resource:: nscp_check
# Author:: Azat Khadiev <anuriq@gmail.com>
#
# Copyright (C) 2016, Parallels IP Holdings GmbH.
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

resource_name :nscp_check

property :command_name, String, name_property: true
property :command, String, required: true
property :arguments, Array, default: []

default_action :add

action :add do
  check_hash = {
    'command' => new_resource.command,
    'arguments' => new_resource.arguments
  }

  checks = node['nscp']['checks'].to_hash
  if checks.key?(new_resource.command_name)
    current_check = checks[new_resource.command_name].to_hash
    if current_check == check_hash
      new_resource.updated_by_last_action(false)
      return
    end
  end
  checks[new_resource.command_name] = check_hash
  node.default['nscp']['checks'] = checks

  template 'nscp_scripts' do
    path "#{node['nscp']['dir']}\\nsclient_scripts.ini"
    cookbook node['nscp']['template_cookbook']
    source node['nscp']['template_scripts_name']
    notifies :restart, "service[#{node['nscp']['service_name']}]", :delayed
  end

  new_resource.updated_by_last_action(true)
end
