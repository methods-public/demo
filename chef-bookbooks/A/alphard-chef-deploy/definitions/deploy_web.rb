#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: deploy_web
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
define :deploy_web_s3, directory: nil, deployment: nil do
  # Defines variables
  name = params[:name]
  directory = params[:directory]
  deployment = params[:deployment]
  bucket = deployment[:bucket]
  if bucket.nil?
    Chef::Log.error("a bucket must be specified for #{name} s3 deployment!")
    return
  end
  headers = deployment[:headers]
  overwrite = deployment[:overwrite]
  cloudfront = deployment[:cloudfront]

  # Includes s3cmd recipe
  include_recipe 'alphard-chef-s3cmd'

  # Synchronizes local directory to s3 bucket
  sync_command = 'sync'
  sync_command = 'put --recursive' if overwrite

  headers_option = ''
  headers_option = (headers.map { |hn, hv| "--add-header='#{hn}':'#{hv}'" }).join(' ') if headers

  sync_command_cloudfront_option = cloudfront ? '--cf-invalidate' : ''
  sync_command_options = "--force --acl-public --delete-removed #{headers_option} #{sync_command_cloudfront_option}"
  sync_command = "#{sync_command} #{sync_command_options} #{directory}/ s3://#{bucket}/"
  s3cmd sync_command
end

define :deploy_web, organization: nil, directory: nil, deployment_type: nil, deployment: nil do
  # Defines variables
  name = params[:name]
  directory = params[:directory]
  deployment_type = params[:deployment_type]
  deployment = params[:deployment]

  # Deploys directory
  case deployment_type
  when 's3'
    deploy_web_s3 name do
      directory directory
      deployment deployment
    end
  else
    Chef::Log.error("invalid deployment type (#{deployment_type}), deployment type must be 'nginx' or 's3'!")
    return
  end
end
