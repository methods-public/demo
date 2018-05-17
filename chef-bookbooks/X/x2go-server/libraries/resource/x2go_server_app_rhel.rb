# frozen_string_literal: true

#
# Cookbook Name:: x2go-server
# Library:: resource/x2go_server_app_rhel
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
    # A Chef provider for the X2go server packages for RHEL and RHEL-alikes.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goServerAppRhel < X2goServerApp
      provides :x2go_server_app, platform_family: 'rhel'

      #
      # Set up EPEL and install the X2go server packages. EPEL must always be
      # set up, even if a custom package source is provided, due to x2go's
      # dependencies on, e.g., sshfs.
      #
      action :install do
        include_recipe 'yum-epel'
        super()
      end
    end
  end
end
