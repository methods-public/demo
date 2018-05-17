#
# Cookbook Name:: rot13
# Resource:: vault
#
# Copyright 2014, Fletcher Nichol
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

actions :create
default_action :create

attribute :path, :kind_of => String, :name_attribute => true
attribute :owner, :kind_of => String
attribute :group, :kind_of => String
attribute :mode, :kind_of => [String, Integer]
attribute :payload, :kind_of => String

include Rot13

def encoded
  Rot13.encode(payload)
end
