# frozen_string_literal: true

#
# Cookbook Name:: snu-sumologic
# Library:: resource/snu_sumo_source_local_file
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

require_relative 'snu_sumologic_collector'

class Chef
  class Resource
    # A more opinionated version of the sumo_source_local_file custom resource
    # that replaces some of its default properties with our own.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class SnuSumoSourceLocalFile < SumoSourceLocalFile
      actions :create, :delete

      # Examine the specified collector resource to find the JSON directory it
      # owns.
      attribute :source_json_directory,
                kind_of: String,
                required: true,
                default: SnuSumologicCollector::DEFAULT_SYNC_SOURCES

      # Default the time zone to UTC and make forcing it the default.
      attribute :time_zone, kind_of: String, default: 'UTC'
      attribute :force_time_zone,
                equal_to: [true, false],
                default: true

      # Default the hostname to the node's FQDN
      attribute :host_name, kind_of: String, default: lazy { node['fqdn'] }

      #
      # After the resource is created, if it includes the :create action, push
      # it into the run state so a collector resource can find it to perform a
      # :manage action.
      #
      def after_created
        run_state_source_list << source_name if action.include?(:create)
        run_state_source_list.uniq!
      end

      #
      # Pull the current array of sources out of the node's run state,
      # defaulting each level to an empty hash as needed.
      #
      # @return [Array<String>] an array of source names
      #
      def run_state_source_list
        rs = run_context.node.run_state
        rs['snu_sumologic'] ||= {}
        rs['snu_sumologic']['sources'] ||= {}
        rs['snu_sumologic']['sources'][source_json_directory] ||= []
      end
    end
  end
end
