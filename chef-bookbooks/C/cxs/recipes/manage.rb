# encoding: UTF-8
#
# Cookbook Name:: cxs
# Recipe:: manage
# Author:: Vassilis Aretakis (<vassilis@aretakis.eu>)
# Copyright:: Copyright (c) 2017 Vassilis Aretakis
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

# This recipe will manage the basic installation of cxs.

cxs 'CXS prepare'
include_recipe 'cxs::_config'


systemd_unit 'cxswatch' do
  action [ :enable, :start ]
end
