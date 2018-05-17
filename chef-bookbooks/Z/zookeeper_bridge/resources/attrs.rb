# encoding: UTF-8
#
# Cookbook Name:: zookeeper_bridge
# Resource:: attrs
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
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

actions :read, :write

attribute :path, kind_of: String, name_attribute: true
attribute :server, kind_of: String, default: nil
attribute :attribute, kind_of: [Chef::Node::VividMash, Hash], required: true
attribute :merge, kind_of: [TrueClass, FalseClass], default: nil
attribute :force_encoding, kind_of: String, default: nil

def initialize(*args)
  super
  @action = :read
end