# frozen_string_literal: true

#
# Cookbook Name:: snu-sumologic
# Library:: provider/snu_sumo_source_local_file
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

class Chef
  class Provider
    # A provider to pair with the modified snu_sumo_source_local_file custom
    # resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class SnuSumoSourceLocalFile < SumoSourceLocalFile
      provides :snu_sumo_source_local_file

      # Ensure the .d config directory exists before trying to create the file
      # in it.
      action :create do
        directory new_resource.source_json_directory do
          owner 'root'
          group 'root'
          mode '0755'
          recursive true
        end
        super()
      end

      # The parent resource doesn't have a :delete action, so let's give it
      # one.
      action :delete do
        file(source_json_path) { action :delete }
      end
    end
  end
end
