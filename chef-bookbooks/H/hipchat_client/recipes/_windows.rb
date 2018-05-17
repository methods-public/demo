#
# Cookbook Name:: hipchat_client
# Recipe:: windows
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

windows_package 'HipChat' do
  source 'https://atlassian.jfrog.io/atlassian/libqt-hipchat/HipChat-4.30.1.1663-win32.msi'
  checksum '7ad43cd85dcbb68a9fde1a1fd1216d2318ad1bfef580ebf631894edbba89407e'
  action :install
end
