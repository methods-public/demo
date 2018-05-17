#
# Cookbook Name:: yum_utils
# Recipe:: yum-epel
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

if node['platform_family'] == 'rhel'
  # "If a recipe is included more than once in a recipe, only the first
  # inclusion will be processed and any subsequent inclusion will be ignored."
  # from http://docs.opscode.com/essentials_cookbook_recipes_in_recipes.html
  include_recipe 'yum-epel::default'
end
