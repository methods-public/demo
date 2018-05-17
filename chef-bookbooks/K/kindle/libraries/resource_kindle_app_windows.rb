# Encoding: UTF-8
#
# Cookbook Name:: kindle
# Library:: resource_kindle_app_windows_direct
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
require_relative 'resource_kindle_app'

class Chef
  class Resource
    # A Chef resource for Windows installs via direct download.
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class KindleAppWindowsDirect < KindleApp
      provides :kindle_app, platform_family: 'windows'

      #
      # On Windows, the only install method supported is a direct download.
      #
      property :source,
               Symbol,
               coerce: proc { |v| v.to_sym },
               equal_to: %i(direct),
               default: :direct

      #
      # The download URL for Kindle for Windows.
      #
      property :url, String, default: 'https://www.amazon.com/kindlepcdownload'

      #
      # Download and install the Windows Kindle package.
      #
      action :install do
        windows_package 'Amazon Kindle' do
          source remote_path
          installer_type :nsis
        end
      end
    end
  end
end
