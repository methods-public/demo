#
# Cookbook Name:: netatalk
# Recipe:: build_aur
#
# Copyright 2010, Opscode, Inc.
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

include_recipe "build-essential"

%w{ libcups avahi }.each do |pkg|
  package pkg
end

pacman_aur "netatalk" do
  pkgbuild_src "PKGBUILD"
  action [:build,:install]
end

# cnid is a separate service on Arch.
service "cnid" do
  action [:enable,:start]
end
