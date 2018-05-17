#
# Cookbook Name:: hipchat_client
# Recipe:: mac_os_x
#
# Copyright 2013, Urbandecoder Labs
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

HC_OSX_VERSION = '4.29.0-732'
HC_OSX_CHECKSUM = 'b033c8e69686810e7f83e0895a90ed22d745af5956b5bb1cf4cda37756dc910b'

remote_file "#{Chef::Config[:file_cache_path]}/HipChat-#{HC_OSX_VERSION}.zip" do
  source "https://s3.amazonaws.com/downloads.hipchat.com/osx/HipChat-#{HC_OSX_VERSION}.zip"
  checksum "#{HC_OSX_CHECKSUM}"
  notifies :run, 'execute[unzip-hipchat]'
end

execute 'unzip-hipchat' do
  command "unzip #{Chef::Config[:file_cache_path]}/HipChat-#{HC_OSX_VERSION}.zip -d /Applications"
  action :nothing
end
