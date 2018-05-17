# frozen_string_literal: true

#
# Cookbook Name:: snu-sumologic
# Recipe:: configuration
#
# Copyright (C) 2014-2018, Socrata, Inc.
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

dbi = data_bag_item(node['sumologic']['credentials']['bag_name'],
                    node['sumologic']['credentials']['item_name'])

include_recipe '::installation'

edit_resource!(:snu_sumologic_collector, 'default') do
  sumo_access_id dbi['accessID']
  sumo_access_key dbi['accessKey']
  action %i[install configure enable start manage]
end
