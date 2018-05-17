#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: install_web_service
#
# Copyright:: 2017, Hydra Technologies, Inc
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
define :install_web_service, configurations: nil, directory: nil do
  # Defines variables
  configurations = params[:configurations]
  configuration = configurations[:configuration]
  name = configuration[:name]
  organization = configuration[:organization]
  user = configuration[:user]
  group = configuration[:group]
  version = configuration[:version]
  is_snapshot = configuration[:is_snapshot]
  clean = configuration[:clean]
  directory = params[:directory]
  version_directory = "#{configuration[:base_directory]}/version"
  archive_directory = configuration[:archive_directory]

  # Defines repository variables
  repository_type = configuration[:repository][:type]
  repository = proc do |key|
    configuration[:repository][repository_type][key]
  end

  # Installs the resources archive if needed
  resource_archive_name = "#{name}-web-service-resources.tar.gz"
  resource_archive_file = "#{archive_directory}/#{resource_archive_name}"

  if clean || !File.exist?(resource_archive_file)

    # Installs archive
    install_archive name do
      packaging configuration[:packaging]
      organization organization
      archive_name resource_archive_name
      archive_directory archive_directory
      repository_type repository_type
      repository repository
      version version
      is_snapshot is_snapshot
    end

    # Cleans directory
    directory directory do
      owner user
      group group
      mode '0755'
      recursive true
      action :delete
    end

    directory directory do
      owner user
      group group
      mode '0755'
      action :create
    end

    # Unpacks archive
    execute "untar archive #{resource_archive_file}" do
      command "tar -xvf #{resource_archive_file} -C #{directory}"
      user user
      group group
      action :run
    end
  end

  # Installs the resources archive if needed
  configuration_archive_name = "#{name}-web-service-configurations.tar.gz"
  configuration_archive_file = "#{archive_directory}/#{configuration_archive_name}"
  configuration_templates_directory = "#{version_directory}/#{configuration[:version]}_templates"

  if clean || !File.exist?(configuration_archive_file)

    # Installs archive
    install_archive name do
      packaging configuration[:packaging]
      organization organization
      archive_name configuration_archive_name
      archive_directory archive_directory
      repository_type repository_type
      repository repository
      version version
      is_snapshot is_snapshot
    end

  end

  if clean || !File.exist?(configuration_templates_directory)

    # Cleans directory
    directory configuration_templates_directory do
      owner user
      group group
      mode '0755'
      recursive true
      action :delete
    end

    directory configuration_templates_directory do
      owner user
      group group
      mode '0755'
      action :create
    end

    # Unpacks archive
    execute "untar archive #{configuration_archive_file}" do
      command "tar -xvf #{configuration_archive_file} -C #{configuration_templates_directory}"
      user user
      group group
      action :run
    end

  end

  # Generates configurations files from templates
  deep_template 'generate configurations files from templates' do
    directory directory
    template_directory configuration_templates_directory
    user user
    group group
    variables configurations
  end

  # Defines deployment variables
  deployment_type = configuration[:deployment][:type]
  deployment = proc do |key|
    configuration[:deployment][deployment_type][key]
  end

  # Deploys content
  deploy_web name do
    organization organization
    directory directory
    deployment_type deployment_type
    deployment deployment
  end
end
