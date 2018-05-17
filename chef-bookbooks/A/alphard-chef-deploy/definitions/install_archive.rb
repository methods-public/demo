#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: install_archive
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
define :install_archive,
       organization: nil,
       packaging: nil,
       archive_name: nil,
       archive_directory: nil,
       repository_type: nil,
       repository: nil,
       version: nil,
       is_snapshot: nil do

  # Defines variables
  name = params[:name]
  organization = params[:organization]
  packaging = params[:packaging]
  archive_name = params[:archive_name]
  archive_directory = params[:archive_directory]
  repository_type = params[:repository_type]
  repository = params[:repository]
  version = params[:version]
  is_snapshot = params[:is_snapshot]

  archive_path = "#{organization}/#{name}/#{version}/#{packaging}s/#{archive_name}"
  archive_file = "#{archive_directory}/#{archive_name}"

  # Deletes local archive if exists
  if File.exist?(archive_file)
    file archive_file do
      action :delete
    end
  end

  # Downloads archive
  if repository_type == 'local'

    archive = "#{repository[:path]}/#{archive_path}"
    file archive_file do
      content IO.read(archive)
    end

  elsif repository_type == 'artifactory'

    archive = "http://#{repository[:host]}:#{repository[:port]}/#{repository[:path]}/#{archive_path}"
    user = repository[:user]
    password = repository[:password]
    execute "download archive #{archive} from artifactory to #{archive_file}" do
      command "wget #{archive} --http-user=#{user} --http-password=#{password} --output-document=#{archive_file}"
      user 'root'
      group 'root'
      action :run
    end

  elsif repository_type == 's3'

    bucket = repository[:releases_bucket]
    bucket = repository[:snapshots_bucket] if is_snapshot

    archive = "s3://#{bucket}/#{archive_path}"

    # Includes s3cmd recipe
    include_recipe 'alphard-chef-s3cmd'

    # Synchronizes files
    command = "get #{archive} #{archive_file}"
    s3cmd command

  else
    Chef::Log.error("invalid repository type (#{repository_type}), repository must be 'local', 'artifactory' or 's3'!")
    return
  end
end
