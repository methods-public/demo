#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-deploy
# Definition:: install_web
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
define :install_web, organization: nil do
  # Defines variables
  name = params[:name]
  organization = params[:organization]
  installer = proc do |configurations|
    # Defines variables
    configuration = configurations[:configuration]
    version_directory = configuration[:version_directory]

    # Installs the package
    if configuration[:packaging] == 'web-application'
      install_web_application configuration[:name] do
        configurations configurations
        directory version_directory
      end
    elsif configuration[:packaging] == 'web-service'
      install_web_service configuration[:name] do
        configurations configurations
        directory version_directory
      end
    else
      Chef::Log.error("invalid packaging type #{configuration[:packaging]}, should be web-application or web-service")
      return
    end
  end

  # Configures and installs
  configure name do
    organization organization
    installer installer
  end
end
