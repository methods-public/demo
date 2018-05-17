# Encoding: UTF-8
#
# Cookbook Name:: kindle
# Library:: resource_kindle_app
#
# Copyright 2015-2016, Jonathan Hartman
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

class Chef
  class Resource
    # A Chef resource for the official Kindle app.
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class KindleApp < Resource
      default_action :install

      #
      # Follow the redirect from URL to get the .exe file download path. Save
      # it as an instance variable so we only have to hit Amazon's web server
      # once.
      #
      # @return [String] the download_url
      #
      def remote_path
        @remote_path ||= Net::HTTP.get_response(URI(url))['location']
      end
    end
  end
end
