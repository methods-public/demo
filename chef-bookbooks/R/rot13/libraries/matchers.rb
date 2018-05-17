#
# Cookbook Name:: rot13
# Library:: matchers
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

if defined?(ChefSpec)
  def create_rot13_vault(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rot13_vault, :create, name)
  end

  def delete_rot13_vault(name)
    ChefSpec::Matchers::ResourceMatcher.new(:rot13_vault, :delete, name)
  end
end
