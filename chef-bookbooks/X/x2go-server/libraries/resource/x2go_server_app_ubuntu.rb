# frozen_string_literal: true

#
# Cookbook Name:: x2go-server
# Library:: resource/x2go_server_app_ubuntu
#
# Copyright 2015-2018, Socrata, Inc.
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

require_relative 'x2go_server_app'

class Chef
  class Resource
    # A Chef provider for the X2go server packages for Ubuntu.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goServerAppUbuntu < X2goServerApp
      provides :x2go_server_app, platform: 'ubuntu'

      #
      # Set up the X2go APT repo and install the server packages.
      #
      action :install do
        apt_update 'default'
        package 'gnupg'
        apt_repository 'x2go' do
          uri 'ppa:x2go/stable'
          distribution node['lsb']['codename']
          only_if { new_resource.source.nil? }
        end
        super()
      end

      #
      # Uninstall the X2go server packages and remove the APT repo.
      #
      action :remove do
        package('x2goserver') { action :purge }
        apt_repository('x2go') { action :remove }
      end
    end
  end
end
