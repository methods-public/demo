# Encoding: UTF-8
#
# Cookbook Name:: dropbox
# Library:: provider_dropbox_mac_os_x
#
# Copyright 2014 Jonathan Hartman
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

require 'net/http'

class Chef
  class Provider
    class Dropbox < Provider
      # A Chef provider for Dropbox pieces specific to Mac OS X
      #
      # @author Jonathan Hartman <j@p4nt5.com>
      class MacOsX < Dropbox
        private

        #
        # Ensure the package resource gets the OS X-specific attributes it needs
        #
        def tailor_package_to_platform
          @package.app('Dropbox')
          @package.volumes_dir('Dropbox Installer')
          @package.source(URI.encode("file://#{download_dest}"))
        end

        #
        # Use the dmg_package resource for OS X
        #
        # @return [Chef::Resource::DmgPackage]
        #
        def package_resource_class
          Chef::Resource::DmgPackage
        end
      end
    end
  end
end
