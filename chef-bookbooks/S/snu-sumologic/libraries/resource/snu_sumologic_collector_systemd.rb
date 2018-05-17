# frozen_string_literal: true

#
# Cookbook Name:: snu-sumologic
# Library:: resource/snu_sumologic_collector_systemd
#
# Copyright (C) 2014-2018, Socrata, Inc.
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

require 'chef/platform/service_helpers'
require_relative 'snu_sumologic_collector'

class Chef
  class Resource
    # Systemd platforms need a little extra help. While Ubuntu appears to
    # automatically reload when new unit files are installed, Debian does not.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class SnuSumologicCollectorSystemd < SnuSumologicCollector
      provides :snu_sumologic_collector_systemd
      provides :snu_sumologic_collector do |_node|
        Chef::Platform::ServiceHelpers.service_resource_providers
                                      .include?(:systemd)
      end

      #
      # The :install and :remove actions should reload Systemd when appropriate.
      #
      %i[install remove].each do |act|
        action act do
          super()

          execute 'Reload Systemd' do
            command 'systemctl daemon-reload'
            action :nothing
            subscribes :run,
                       "sumologic_collector[#{new_resource.name}]",
                       :immediately
          end
        end
      end
    end
  end
end
