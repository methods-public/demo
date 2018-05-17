# Encoding: UTF-8
#
# Cookbook Name:: kindle
# Library:: resource_kindle_app_mac_os_x
#
# Copyright 2015-2016, Jonathan Hartman
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

require 'net/http'
require 'chef/exceptions'
require_relative 'resource_kindle_app'

class Chef
  class Resource
    # A Chef resource for installing the Kindle app on OS X platforms.
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class KindleAppMacOsX < KindleApp
      provides :kindle_app, platform_family: 'mac_os_x'

      #
      # Allow the user to choose from installing via :app_store (default)
      # or :direct download.
      #
      property :source,
               Symbol,
               coerce: proc { |v| v.to_sym },
               equal_to: %i(app_store direct),
               default: :app_store

      #
      # The download URL for Kindle for Mac.
      #
      property :url, String, default: 'https://www.amazon.com/kindlemacdownload'

      #
      # Perform the appropriate install action, either installing from the App
      # Store or downloading and installing the .dmg file.
      #
      action :install do
        case new_resource.source
        when :app_store
          include_recipe 'mac-app-store'
          mac_app_store_app 'Kindle'
        when :direct
          dmg_package 'Kindle' do
            source remote_path
          end
        end
      end

      #
      # For App Store installations only, an upgrade action is supported.
      #
      action :upgrade do
        case new_resource.source
        when :app_store
          include_recipe 'mac-app-store'
          mac_app_store_app 'Kindle' do
            action :upgrade
          end
        when :direct
          raise(Chef::Exceptions::ValidationFailed,
                'Direct download install method does not support upgrades')
        end
      end
    end
  end
end
