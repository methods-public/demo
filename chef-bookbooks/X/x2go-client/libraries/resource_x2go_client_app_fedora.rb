# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: x2go-client
# Library:: resource_x2go_client_app_fedora
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
    # A Fedora implementation of the x2go_client_app resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goClientAppFedora < X2goClientApp
      provides :x2go_client_app, platform: 'fedora'

      #
      # Install the X2go client package, no special repository needed.
      #
      action :install do
        package(new_resource.source || 'x2goclient')
      end

      #
      # Remove the X2go client package.
      #
      action :remove do
        package('x2goclient') { action :remove }
      end
    end
  end
end
