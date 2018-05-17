# Cookbook Name:: appveyor-agent
# Resource:: agent
#
# Copyright (C) 2016
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

resource_name :appveyor_agent
property :version, String, name_property: true
property :access_key, String, required: true
property :deployment_group, required: true
property :installer_url, String, default: lazy { "https://www.appveyor.com/downloads/deployment-agent/#{version}/AppveyorDeploymentAgent.msi" }
property :install_path, String, default: lazy { 'C:\\Program Files (x86)\\AppVeyor\\DeploymentAgent\\Appveyor.DeploymentAgent.Service.exe' }

default_action :install

action :install do
  include_recipe 'windows'

  windows_package 'AppveyorDeploymentAgent' do
    source installer_url
    installer_type :msi
    options "/quiet /qn /norestart /log install.log ENVIRONMENT_ACCESS_KEY=#{access_key}"
    not_if { ::File.exist?(install_path) }
  end

  registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\AppVeyor\\DeploymentAgent' do
    values [{
      name: 'DeploymentGroup',
      type: :string,
      data: deployment_group
    }]
    action :create
  end

  service 'Appveyor.DeploymentAgent' do
    action :restart
  end
end
