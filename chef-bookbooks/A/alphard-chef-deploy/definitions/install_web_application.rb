#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: install_web_application
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
define :install_web_application, configurations: nil, directory: nil do
  # Defines variables
  configurations = params[:configurations]
  configuration = configurations[:configuration]
  name = configuration[:name]
  organization = configuration[:organization]
  user = configuration[:user]
  group = configuration[:group]
  environment = configuration[:environment]
  version = configuration[:version]
  is_snapshot = configuration[:is_snapshot]
  clean = configuration[:clean]
  directory = params[:directory]
  archive_directory = configuration[:archive_directory]
  deploy = false

  # Defines repository variables
  repository_type = configuration[:repository][:type]
  repository = proc do |key|
    configuration[:repository][repository_type][key]
  end

  # Installs the archive if needed
  archive_name = "#{name}-web-application-#{environment}.tar.gz"
  archive_file = "#{archive_directory}/#{archive_name}"

  if clean || !File.exist?(archive_file)
    # Installs archive
    install_archive name do
      packaging configuration[:packaging]
      organization organization
      archive_name archive_name
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
    execute "untar archive #{archive_file}" do
      command "tar -xvf #{archive_file} -C #{directory}"
      user user
      group group
      action :run
    end

    # Sets the deploy flag
    deploy = true

  end

  # Deploys web
  if deploy
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
end
