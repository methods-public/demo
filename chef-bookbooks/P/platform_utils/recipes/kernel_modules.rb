#
# Cookbook Name:: platform_utils
# Recipe:: kernel_modules
#
# Copyright 2017, whitestar
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

::Chef::Recipe.send(:include, PlatformUtils::Helper)

# for old distributions.
dir = '/etc/modules-load.d'
resources(directory: dir) rescue directory dir do
  owner 'root'
  group 'root'
  mode '0755'
end

node['platform_utils']['kernel_modules']['loaded_modules'].each {|mod_name|
  load_kernel_module(mod_name)
}
