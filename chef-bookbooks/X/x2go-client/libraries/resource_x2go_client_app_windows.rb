# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: x2go-client
# Library:: resource_x2go_client_app_windows
#
# Copyright 2015-2016, Socrata, Inc.
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

require_relative 'resource_x2go_client_app'

class Chef
  class Resource
    # A Windows implementation of the x2go_client_app resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goClientAppWindows < X2goClientApp
      PATH ||= ::File.expand_path('/Program Files (x86)/x2goclient')
      URL ||= 'http://code.x2go.org/releases/' \
              'X2GoClient_latest_mswin32-setup.exe'

      provides :x2go_client_app, platform_family: 'windows'

      #
      # Use a windows_package resource to download and install and remove the
      # X2go client.
      #
      %i(install remove).each do |a|
        action a do
          s = new_resource.source || URL
          windows_package 'X2Go Client for Windows' do
            source s
            installer_type :nsis
            action a
          end
        end
      end
    end
  end
end
