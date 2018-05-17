#
# Cookbook Name:: mongo_chef_gem
# Provider:: mongo_chef_gem
#
# Copyright 2015 Andrei Skopenko
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

class Chef
  class Provider
    #
    class MongoChefGem < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      provides :mongo_chef_gem

      def whyrun_supported?
        true
      end

      action :install do
        Chef::Log.warn('installing mongo_chef_gem')

        gcc = package 'gcc' do
          action :nothing
          only_if { platform_family?('rhel') }
        end
        gcc.run_action(:install)

        sasldev_pkg = if platform_family?('rhel')
                        'cyrus-sasl-devel'
                      else
                        ['libsasl2-dev', 'make']
                      end

        package sasldev_pkg do
          action :nothing
        end.run_action(:install)

        chef_gem 'mongo' do
          version new_resource.mongo_version
          action :install
        end

        chef_gem 'bson_ext' do
          version new_resource.bson_ext_version
          action :install
        end
      end

      action :remove do
        chef_gem 'mongo' do
          action :remove
        end
        chef_gem 'bson_ext' do
          action :remove
        end
      end
    end
  end
end
