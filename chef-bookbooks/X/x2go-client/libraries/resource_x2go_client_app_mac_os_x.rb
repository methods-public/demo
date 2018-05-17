# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: x2go-client
# Library:: resource_x2go_client_app_mac_os_x
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

require 'chef/dsl/include_recipe'
require_relative 'resource_x2go_client_app'

class Chef
  class Resource
    # An OS X implementation of the x2go_client_app resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goClientAppMacOsX < X2goClientApp
      PATH ||= '/Applications/x2goclient.app'

      include Chef::DSL::IncludeRecipe

      provides :x2go_client_app, platform_family: 'mac_os_x'

      #
      # Use a dmg_package resource to download and install the X2go client.
      #
      action :install do
        include_recipe 'xquartz'
        s = new_resource.source || remote_path
        dmg_package 'x2goclient' do
          source s
        end
      end

      #
      # Delete the X2go client application directory.
      #
      action :remove do
        directory PATH do
          recursive true
          action :delete
        end
      end

      #
      # Return the remote URL of the .dmg file to download. X2go publishes
      # two packages for OS X: one for >= 10.9 and one for < 10.9.
      #
      # @return [String] a .dmg package URL for the current platform
      #
      def remote_path
        pv = node['platform_version']
        file = if Gem::Version.new(pv) >= Gem::Version.new('10.9')
                 'X2GoClient_latest_macosx_10_9.dmg'
               else
                 'X2GoClient_latest_macosx.dmg'
               end
        "http://code.x2go.org/releases/#{file}"
      end
    end
  end
end
