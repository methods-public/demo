# frozen_string_literal: true

#
# Cookbook Name:: snu-sumologic
# Library:: helpers/collector
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
require 'chef/resource'

module SnuSumologicCookbook
  module Helpers
    # Helper methods for the snu_sumologic_collector resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    module Collector
      #
      # Declare and return a sumologic_collector resource with all our shared
      # properties set.
      #
      def collector_resource(act)
        sumologic_collector new_resource.name do
          state_collector_properties.each { |k, v| send(k, v) }
          additional_collector_properties.each { |k, v| send(k, v) }
          action act
        end
      end

      #
      # Return a hash of all non-nil state properties, excluding sources
      # (the accumulator tracking property) and additional_properties (what
      # method_missing uses to make arbitrary other properties work).
      #
      # @return [Hash] state properties
      #
      def state_collector_properties
        new_resource.class.state_properties.map(&:name)
                    .each_with_object({}) do |prop, hsh|
          next if %i[sources additional_properties].include?(prop)
          next if new_resource.send(prop).nil?
          hsh[prop] = new_resource.send(prop)
        end
      end

      #
      # Return all non-nil additional properties that have been added via
      # method_missing.
      #
      # @return [Hash] additional properties
      #
      def additional_collector_properties
        new_resource.additional_properties.reject { |_, v| v.nil? }
      end
    end
  end
end
