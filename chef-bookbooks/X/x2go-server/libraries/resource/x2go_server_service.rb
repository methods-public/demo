# frozen_string_literal: true

#
# Cookbook Name:: x2go-server
# Library:: resource/x2go_server_service
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

require 'chef/resource'
require 'chef/resource/service'

class Chef
  class Resource
    # A Chef resource for the X2go server service.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class X2goServerService < Resource
      default_action %i[enable start]
    end
  end
end
