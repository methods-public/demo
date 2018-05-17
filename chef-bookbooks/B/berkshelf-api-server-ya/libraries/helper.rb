#
# Cookbook Name:: berkshelf-api-server-ya
# Library:: Helper
#
# Copyright 2013, whitestar
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

module BerkshelfAPIServerYA
  # Helper methods
  module Helper
    def chef_gem_chef_vault
      pkg = 'chef-vault'
      resources(chef_gem: pkg) rescue chef_gem pkg do
        compile_time true if respond_to?(:compile_time)
        clear_sources node[:berkshelf_api][:chef_gem][:clear_sources]
        source node[:berkshelf_api][:chef_gem][:source]
        options node[:berkshelf_api][:chef_gem][:options]
        version node[:berkshelf_api][:"chef-vault"][:version]
        action :install
      end
    end
  end
end
