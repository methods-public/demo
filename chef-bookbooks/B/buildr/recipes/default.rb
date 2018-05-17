#
# Cookbook Name:: buildr
# Recipe:: default
#
# Copyright 2013, Cyberfonica Dev Team
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

include_recipe 'build-essential'
include_recipe 'java'
include_recipe 'java::set_java_home'

pkgs = []

case node.platform
when "debian", "ubuntu"
	pkgs = ["ruby-full", "ruby-dev", "libopenssl-ruby", "rubygems"]
when "rhel", "fedora", "centos", "amazon", "scientific"
	pkgs = ["ruby", "rubygems", "ruby-devel"]
end

pkgs.each {|p|
	package p
}

gem_package "buildr" do
	gem_binary "/usr/bin/gem"
end
