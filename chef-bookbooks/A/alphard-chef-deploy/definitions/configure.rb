#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: configure
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
default_installer = proc do |_configurations|
  raise 'you must specify a installer'
end

define :configure, organization: nil, installer: default_installer do
  # Retrieves the organization from the definition parameters
  # If the name is nil, the recipe will stop and no further operation will be done
  organization = params[:organization]

  if organization.nil?
    Chef::Log.error('an organization must be provided to this definition!')
    return
  end

  Chef::Log.info("organization: #{organization}")

  # Retrieves the name from the definition parameters
  # If the name is nil, the recipe will stop and no further operation will be done
  name = params[:name]

  if name.nil?
    Chef::Log.error('a name must be provided to this definition!')
    return
  end

  Chef::Log.info("name: #{name}")

  # Retrieves the environment
  environment = node.chef_environment

  if environment.nil?
    Chef::Log.error('environment must not be nil!')
    return
  end

  Chef::Log.info("environment: #{environment}")

  # Detects the platform
  platform_os = case node['platform_family']
                when 'windows'
                  'windows'
                when 'mac_os_x'
                  'macosx'
                else
                  'linux'
                end
  platform_arch = 1.size == 4 ? '32' : '64'
  platform = "#{platform_os}#{platform_arch}"

  Chef::Log.info("platform: #{platform}")

  # Retrieves the configuration. The node must be present in the environment.
  # If the node is nil, the recipe will stop and no further operation will be done.
  def mash(key = nil, p = nil)
    n = p.nil? ? node : p
    m = key.nil? ? n : n[key]
    m.nil? ? Mash.new : m
  end

  environment_configuration = mash.merge(environment: environment,
                                         platform: platform)
  organization_configuration = mash(organization).merge(organization: organization,
                                                        environment: environment,
                                                        platform: platform)
  default_cookbook_configuration = mash(nil, node['alphard']['deploy'])
  global_configuration = mash(:global, organization_configuration)
  local_configuration = mash(name, organization_configuration)

  if local_configuration.nil?
    Chef::Log.error("a local configuration must be provided to the '#{name}' definition!")
    return
  end

  def deep_merge(min, mout)
    Mash.from_hash(
      min.to_hash.merge(mout.to_hash) do |_key, v1, v2|
        if v1.is_a?(Hash) && v2.is_a?(Hash)
          deep_merge(v1, v2)
        else
          v2
        end
      end
    )
  end

  configuration = default_cookbook_configuration
  configuration = deep_merge(configuration, global_configuration)
  configuration = deep_merge(configuration, local_configuration)

  # Retrieves the packaging from the definition parameters
  # If the name is nil, the recipe will stop and no further operation will be done
  packaging = configuration[:packaging]

  if packaging.nil?
    Chef::Log.error('a packaging must be provided to this definition!')
    return
  end

  Chef::Log.info("packaging: #{packaging}")

  # Retrieves the version. The version must be present in the environment.
  # If the version is nil, the recipe will stop and no further operation will be done.
  version = configuration[:version]

  if version.nil?
    Chef::Log.error('a version must be provided to this definition!')
    return
  end

  Chef::Log.info("version: #{version}")

  suffixes = node['alphard']['deploy']['snapshot_suffixes'] || []
  is_snapshot = suffixes.inject(false) do |flag, suffix|
    flag || !version.to_s.index(suffix).nil?
  end

  Chef::Log.info("is snapshot: #{is_snapshot}")

  # Retrieves the description and set it to the empty string is is not present in the environment.
  description = configuration[:description]
  description = '' if description.nil?

  Chef::Log.info("description: #{description}")

  # Retrieves the user. The version must be present in the environment.
  # If the user is nil, the recipe will stop and no further operation will be done.
  user = configuration[:user]

  if user.nil?
    Chef::Log.error('a user must be provided to this definition!')
    return
  end

  Chef::Log.info("user: #{user}")

  group = configuration[:group]

  if group.nil?
    Chef::Log.error('a group must be provided to this definition!')
    return
  end

  Chef::Log.info("group: #{group}")

  # Checks if the installation must be cleaned
  clean = (is_snapshot && configuration[:clean] != 'false') || configuration[:clean] == 'true'

  Chef::Log.info("clean: #{clean}")

  # Checks if the directory already exists.
  # If the directory does not exist, it creates it with the provided user and group.
  # Creates other directories
  directory = "#{configuration[:base]}/#{name}"

  directory directory do
    owner user
    group group
    mode '0755'
    recursive true
    action :create
  end

  # Retrieves the previous version. The version is located in a file.
  # If the file exists, the current is set with the content of the file.
  # If the file doesn't exist the current version is set to 'nil'
  version_file = "#{directory}/#{configuration[:version_file]}"

  previous_version = nil
  if File.exist?(version_file)
    file = File.open(version_file, 'rb')
    previous_version = file.read
  end

  Chef::Log.info("previous version: #{previous_version}")

  # Creates directories
  archive_directory = "#{directory}/archive"
  next_archive_directory = "#{archive_directory}/#{version}"
  version_directory_name = 'version'
  version_directory = "#{directory}/#{version_directory_name}"
  next_version_directory = "#{version_directory}/#{version}"
  current_directory = "#{directory}/current"

  if clean || version != previous_version
    [directory, archive_directory, next_archive_directory,
     version_directory, next_version_directory, current_directory].each do |d|
      directory d do
        owner user
        group group
        mode '0755'
        action :create
      end
    end
  end

  Chef::Log.info("directory: #{directory}")
  Chef::Log.info("archive directory: #{next_archive_directory}")
  Chef::Log.info("version directory: #{next_version_directory}")
  Chef::Log.info("current directory: #{current_directory}}")

  # Updates configurations
  configuration = configuration.merge(name: name,
                                      is_snapshot: is_snapshot,
                                      clean: clean,
                                      previous_version: previous_version,
                                      organization: organization,
                                      environment: environment,
                                      platform: platform,
                                      base_directory: directory,
                                      archive_directory: next_archive_directory,
                                      version_directory: next_version_directory,
                                      current_directory: current_directory)
  configurations = { environment_configuration: environment_configuration,
                     organization_configuration: organization_configuration,
                     configuration: configuration }

  Chef::Log.debug(JSON.pretty_generate(JSON.parse(configuration.to_json)))

  # Triggers the installer
  installer = params[:installer]
  installer.call(configurations)

  if clean || version != previous_version
    # Deletes old versions except current and previous version ones
    find_command = "find #{version_directory}/ * -maxdepth 0 -type d"
    find_command += " ! -name '#{version_directory_name}' ! -name '#{version}'"
    find_command += " ! -name '#{previous_version}' -exec rm -rf '{}' ';'"
    execute find_command do
      command find_command
      returns [0, 1]
      user user
      group group
      cwd version_directory
      action :run
    end

    # Deletes old archives except current and previous version ones
    find_command = "find #{archive_directory}/ * -maxdepth 0 -type f"
    find_command += " ! -name '*#{version}*' ! -name '*#{previous_version}*'"
    find_command += " -exec rm -f '{}' ';'"
    execute find_command do
      command find_command
      returns [0, 1]
      user user
      group group
      cwd archive_directory
      action :run
    end

    # Writes the version in the version file
    file version_file.to_s do
      owner user
      group group
      content version
      action :create
    end
  end
end
