#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: install
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
define :install, organization: nil do
  # Defines includes
  include_recipe 'java'

  # Defines variables
  name = params[:name]
  organization = params[:organization]
  installer = proc do |configurations|
    # Defines variables
    configuration = configurations[:configuration]
    version_directory = configuration[:version_directory]
    current_directory = configuration[:current_directory]

    # Defines and creates jvm directories
    current_temporary_directory = "#{current_directory}/#{configuration[:temporary_directory]}"
    current_log_directory = "#{current_directory}/#{configuration[:log_directory]}"
    current_library_directory = "#{current_directory}/#{configuration[:library_directory]}"
    current_configuration_directory = "#{current_directory}/#{configuration[:configuration_directory]}"
    current_binary_directory = "#{current_directory}/#{configuration[:binary_directory]}"

    version_library_directory = "#{version_directory}/#{configuration[:library_directory]}"
    version_configuration_directory = "#{version_directory}/#{configuration[:configuration_directory]}"
    version_binary_directory = "#{version_directory}/#{configuration[:binary_directory]}"

    [current_temporary_directory, current_log_directory, version_directory].each do |d|
      directory d do
        owner configuration[:user]
        group configuration[:group]
        mode '0755'
        action :create
      end
    end

    # Updates configurations
    configuration = configuration.merge(library_path: current_library_directory,
                                        configuration_path: current_configuration_directory,
                                        binary_path: current_binary_directory,
                                        temporary_path: current_temporary_directory,
                                        log_path: current_log_directory)
    configurations = configurations.merge(configuration: configuration)

    # Installs package
    if configuration[:packaging] == 'application'
      install_application configuration[:name] do
        configurations configurations
        directory version_directory
      end
    elsif configuration[:packaging] == 'service'
      install_service configuration[:name] do
        configurations configurations
        directory version_directory
        library_directory version_library_directory
        configuration_directory version_configuration_directory
        binary_directory version_binary_directory
      end
    else
      Chef::Log.debug("invalid packaging type #{configuration[:packaging]}, should be 'application' or 'service'")
      return
    end

    # Links current directories to version directories
    { current_library_directory => version_library_directory,
      current_configuration_directory => version_configuration_directory,
      current_binary_directory => version_binary_directory }.each do |target_file, to|
      link target_file do
        owner user
        group group
        target_file target_file
        to to
        action :create
      end
    end

    # Installs service
    service_name = "#{cookbook_name}-#{recipe_name}"
    service_class_path = "#{current_library_directory}/classes"
    service_class_path += ":#{current_library_directory}/jars/*"
    service_class_path += ":#{current_configuration_directory}"
    service_library_path = "#{current_library_directory}/natives/#{configuration[:platform]}"
    service_java_options = "-Dalphard.service.version=#{configuration[:version]}"
    service_java_options += " -Dalphard.service.date=#{Time.now.strftime('%Y%m%d%H%M%S')}"
    service_java_options += " -cp #{service_class_path} #{configuration[:java_options]}"
    service_java_options += " -Djava.library.path=#{service_library_path}"
    service_command = configuration[:java_path]
    service_command += " #{service_java_options}"
    service_command += " #{configuration[:main_class]}"
    service_command += " #{configuration[:main_arguments]}"
    service_monit_checks = configuration[:monit_checks] || []
    service_monit_checks = service_monit_checks.concat(['if does not exist then restart'])

    poise_service service_name do
      command service_command
      directory current_log_directory
    end

    include_recipe 'poise-monit'

    monit_check service_name do
      check service_monit_checks
    end
  end

  # Configures and installs
  configure name do
    organization organization
    installer installer
  end
end
