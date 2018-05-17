# frozen_string_literal: true

#
# Cookbook Name:: snu-sumologic
# Library:: resource/snu_sumologic_collector
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
require_relative '../helpers/collector'

class Chef
  class Resource
    # The sumologic_collector resource uses the LWRP DSL, which means we can't
    # easily subclass it and need to wrap a new resource around it instead.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class SnuSumologicCollector < Resource
      DEFAULT_SYNC_SOURCES ||= '/etc/sumo.d'.freeze

      provides :snu_sumologic_collector do |_node|
        !Chef::Platform::ServiceHelpers.service_resource_providers
                                       .include?(:systemd)
      end

      default_action %i[install configure enable start manage]

      # Ensure the Sumo credentials don't leak to any logs.
      property :sumo_access_id, String, sensitive: true
      property :sumo_access_key, String, sensitive: true

      # Use the installDir attribute by default for the dir.
      property :dir, String, default: '/opt/SumoCollector'

      # Use the node's FQDN as the default collector name.
      property :collector_name, String, default: lazy { node.name }

      # Use the .d dir in the JSON path as the sync source.
      property :sync_sources, String, default: DEFAULT_SYNC_SOURCES

      # We're using the cloud so collectors should default to ephemeral.
      property :ephemeral, [true, false], default: true

      # The collector name includes a unique instance ID, so it's safe to
      # clobber if the same collector re-registers itself.
      property :clobber, [true, false], default: true

      # Default the runas_username to root. If we don't specify a user, the
      # sumo installer has trouble when run from a Chef process that's not a
      # descendent of a login shell.
      property :runas_username, String, default: 'root'

      # The Java heap sizes should default to 256.
      property :wrapper_java_initmemory, Integer, default: 256
      property :wrapper_java_maxmemory, Integer, default: 256

      # The list of sources should default to a pull from the run state of
      # every source that's registered itself with this collector's config
      # directory.
      property :sources,
               Array,
               default: lazy { |r|
                 r.node.run_state.dig('snu_sumologic',
                                      'sources',
                                      r.sync_sources) || []
               }

      # Provide a place to store any properties declared by #method_missing.
      property :additional_properties, Hash, default: {}

      #
      # Pass any other property methods on to the underlying
      # sumologic_collector resource so we don't have to keep track of what it
      # supports.
      #
      # (see Chef::Resource#method_missing)
      #
      def method_missing(method_symbol, *args, &block)
        super
      rescue NoMethodError
        raise if !block.nil? || args.length != 1
        new_props = additional_properties.merge(method_symbol => args[0])
        additional_properties(new_props)
      end

      #
      # We don't need anything special out of respond_to_missing? since all the
      # missing methods we allow get saved into additional_properties.
      #
      # (see Object#respond_to_missing)
      #
      def respond_to_missing?(method_symbol, include_private = false)
        super
      end

      #
      # Load the existing sources as defined on the filesystem. Every other
      # property is handled by file/template/etc. sub-resources for which the
      # current value doesn't need to be loaded.
      #
      load_current_value do |desired|
        srcs = if Dir.exist?(desired.sync_sources)
                 (Dir.entries(desired.sync_sources) - %w[. ..]).map do |i|
                   ::File.basename(i, '.json')
                 end
               else
                 []
               end
        sources(srcs)
      end

      #
      # The :install action should ensure the .d config directory is created.
      #
      action :install do
        directory new_resource.sync_sources do
          owner 'root'
          group 'root'
          mode '0755'
          recursive true
        end

        collector_resource(:install)
      end

      #
      # The :install_and_configure action should not be supported to prevent
      # confusion the differences between it and :install + :configure run
      # separately.
      #

      #
      # The :configure action should skip the restart notification in the
      # sumologic_collector resource and set one of its own.
      #
      action :configure do
        collector_resource(:configure)
        edit_resource!(:sumologic_collector, new_resource.name) do
          skip_restart true

          if new_resource.action.include?(:start)
            notifies :restart, new_resource
          end
        end
      end

      #
      # The :start action should handle the extra :configure and :restart
      # when the collector's started for the first time and overwrites the
      # user.properties file.
      #
      action :start do
        collector_resource(:start)
        unless ::File.exist?(::File.join(new_resource.dir, 'data'))
          edit_resource!(:sumologic_collector, new_resource.name) do
            notifies :configure, new_resource, :immediately
            notifies :restart, new_resource, :immediately
          end
        end
      end

      #
      # Every other action should be directly passed on to an underlying
      # sumlogic_collector resource.
      #
      %i[remove stop restart enable disable].each do |act|
        action(act) { collector_resource(act) }
      end

      #
      # Delete every Sumo source that's in the current resource but not the
      # new one.
      #
      action :manage do
        with_run_context new_resource.run_context do
          (current_resource.sources - new_resource.sources).each do |src|
            snu_sumo_source_local_file src do
              source_json_directory new_resource.sync_sources
              action :delete
            end
          end
        end
      end

      action_class do
        include SnuSumologicCookbook::Helpers::Collector
      end
    end
  end
end
