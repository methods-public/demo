# frozen_string_literal: true

#
# Cookbook Name:: x2go-server
# Library:: resource/x2go_server_service_rhel
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

require 'chef/resource/service'
require_relative 'x2go_server_service'

class Chef
  class Resource
    # A Chef resource for the X2go server service on RHEL and RHEL-alike
    # platforms where the service name is 'x2gocleansessions' instead of
    # 'x2goserver'.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goServerServiceRhel < X2goServerService
      provides :x2go_server_service, platform_family: 'rhel'
      provides :x2go_server_service, platform: 'fedora'

      #
      # Iterate over each service action and pass it on to a normal service
      # resource.
      #
      Chef::Resource::Service.allowed_actions.each do |a|
        action a do
          service 'x2gocleansessions' do
            action a
          end
        end
      end
    end
  end
end
