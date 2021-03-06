#
# Cookbook Name:: trafficserver
# Recipe:: package_dependency
#
# Copyright 2014, Virender Khatri
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

packages = value_for_platform_family(
  'rhel' => %w(gcc gcc-c++ make autoconf libtool libcap openssl-devel tcl-devel pcre pcre-devel libxml2-devel hwloc-devel),
  'debian' => %w(gcc make autoconf libtool libcap2 libssl-dev tcl-dev libpcre3-dev libxml2-dev)
)

packages.each do |p|
  package p
end
