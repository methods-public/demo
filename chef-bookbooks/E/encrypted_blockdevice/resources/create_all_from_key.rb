#
# Cookbook Name:: filesystem
# Resource:: create_all_from_key
#
# Copyright 2013 Alex Trull
# Copyright 2013 Medidata Worldwide
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# We default to creating all encrypted blocks found in the key
actions :create
default_action :create

# The name attribute is the key of the encrypted blocks. 
attribute :name, :kind_of => String, :name_attribute => true

# default action is :create
def initialize(*args)
  super
  @action = :create
end

