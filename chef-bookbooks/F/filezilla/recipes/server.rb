#
# Author:: Ryan Lee (<ryan@ryanl.ee>)
# Cookbook Name:: filezilla
# Recipe:: server
#
# Copyright (c) 2015 Ryan Lee, All Rights Reserved.
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

# Installs the FileZilla Server

filezilla_server = remote_file node['filezilla']['server']['exe'] do
  source node['filezilla']['server']['url']
  path File.join('C:\\',node['filezilla']['server']['exe'])
  action :create
end

windows_package "FileZilla Install" do
source File.join('C:\\',node['filezilla']['server']['exe'])
installer_type :custom
options "/S /user=all"
action :install
end

# Remove the downloaded exe
file File.join('C:\\',node['filezilla']['server']['exe']) do
  action :delete
  only_if { filezilla_server.updated_by_last_action? }
end
