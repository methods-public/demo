#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: install_service
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
define :install_service,
       configurations: nil,
       directory: nil,
       library_directory: nil,
       configuration_directory: nil,
       binary_directory: nil do
  # Defines variables
  configurations = params[:configurations]
  configuration = configurations[:configuration]
  name = configuration[:name]
  organization = configuration[:organization]
  user = configuration[:user]
  group = configuration[:group]
  platform = configuration[:platform]
  version = configuration[:version]
  is_snapshot = configuration[:is_snapshot]
  clean = configuration[:clean]
  directory = params[:directory]
  archive_directory = configuration[:archive_directory]
  library_directory = params[:library_directory]
  configuration_directory = params[:configuration_directory]
  configuration_template_directory = "#{directory}/#{configuration[:configuration_directory]}_templates"
  binary_directory = params[:binary_directory]
  binary_platform_directory = "#{binary_directory}/#{platform}"
  binary_template_directory = "#{directory}/#{configuration[:binary_directory]}_templates"

  # Defines repository variables
  repository_type = configuration[:repository][:type]
  repository = proc do |key|
    configuration[:repository][repository_type][key]
  end

  # Installs the libraries archive if needed
  library_archive_name = "#{name}-service-libraries-#{platform}.tar.gz"
  library_archive_file = "#{archive_directory}/#{library_archive_name}"

  if clean || !File.exist?(library_archive_file)
    # Installs library archive
    install_archive name do
      packaging :service
      organization organization
      archive_name library_archive_name
      archive_directory archive_directory
      repository_type repository_type
      repository repository
      version version
      is_snapshot is_snapshot
    end

    # Cleans library directory
    directory library_directory do
      owner user
      group group
      mode '0755'
      recursive true
      action :delete
    end

    directory library_directory do
      owner user
      group group
      mode '0755'
      action :create
    end

    # Unpacks library archive
    execute "untar archive #{library_archive_file}" do
      command "tar -xvf #{library_archive_file} -C #{library_directory}"
      user user
      group group
      action :run
    end
  end

  # Installs the configuration archive if needed
  configuration_archive_name = "#{name}-service-configurations.tar.gz"
  configuration_archive_file = "#{archive_directory}/#{configuration_archive_name}"

  if clean || !File.exist?(configuration_archive_file)
    # Installs configuration archive
    install_archive name do
      packaging :service
      organization organization
      archive_name configuration_archive_name
      archive_directory archive_directory
      repository_type repository_type
      repository repository
      version version
      is_snapshot is_snapshot
    end

    # Creates configuration archive template directory
    directory configuration_template_directory do
      owner user
      group group
      mode '0755'
      action :create
    end

    # Unpacks configuration archive
    execute "untar archive #{configuration_archive_file}" do
      command "tar -xvf #{configuration_archive_file} -C #{configuration_template_directory}"
      user user
      group group
      action :run
    end

    # Cleans configuration directory
    directory configuration_directory do
      owner user
      group group
      mode '0755'
      recursive true
      action :delete
    end

    directory configuration_directory do
      owner user
      group group
      mode '0755'
      action :create
    end
  end

  # Generates configuration files from templates
  deep_template 'generate configuration files from templates' do
    directory configuration_directory
    template_directory configuration_template_directory
    user user
    group group
    variables configurations
  end

  # Installs the binaries archive if needed
  binary_archive_name = "#{name}-service-binaries-#{platform}.tar.gz"
  binary_archive_file = "#{archive_directory}/#{binary_archive_name}"

  if clean || !File.exist?(binary_archive_file)
    # Installs binary archive
    install_archive name do
      packaging :service
      organization organization
      archive_name binary_archive_name
      archive_directory archive_directory
      repository_type repository_type
      repository repository
      version version
      is_snapshot is_snapshot
    end

    # Creates binary archive template directory
    directory binary_template_directory do
      owner user
      group group
      mode '0755'
      action :create
    end

    # Unpacks binary archive
    execute "untar archive #{binary_archive_file}" do
      command "tar -xvf #{binary_archive_file} -C #{binary_template_directory}"
      user user
      group group
      action :run
    end

    # Cleans binary directory
    directory binary_platform_directory do
      owner user
      group group
      mode '0755'
      recursive true
      action :delete
    end

    directory binary_platform_directory do
      owner user
      group group
      mode '0755'
      action :create
    end
  end

  # Generates binary files from templates
  deep_template 'generate binary files from templates' do
    directory binary_platform_directory
    template_directory binary_template_directory
    user user
    group group
    variables configurations
  end
end
