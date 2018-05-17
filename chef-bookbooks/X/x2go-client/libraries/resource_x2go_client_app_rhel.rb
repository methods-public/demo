# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: x2go-client
# Library:: resource_x2go_client_app_rhel
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
    # A RHEL and RHEL-alike implementation of the x2go_client_app resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goClientAppRhel < X2goClientApp
      include Chef::DSL::IncludeRecipe

      provides :x2go_client_app, platform: %w(redhat centos scientific)

      #
      # Set up EPEL and install the X2go client packages. EPEL must always be
      # set up, even if a custom package source is provided, due to x2go's
      # dependencies on, e.g., sshfs.
      #
      action :install do
        include_recipe 'yum-epel'
        package(new_resource.source || 'x2goclient')
      end

      #
      # Remove the X2go client package. Since we can't be sure whether EPEL
      # is being used for other packages, it can't be removed.
      #
      action :remove do
        package('x2goclient') { action :remove }
      end
    end
  end
end
