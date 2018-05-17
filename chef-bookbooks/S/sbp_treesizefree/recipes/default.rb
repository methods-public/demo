#
# Cookbook Name:: sbp_treesizefree
# Recipe:: default
#
# Copyright 2014, Schuberg Philis
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

windows_zipfile node['treesizefree']['install_dir'] do
	source node['treesizefree']['url']
  checksum node['treesizefree']['checksum']
 	action :unzip
  not_if { File.exists?("#{node['treesizefree']['install_dir']}/TreeSizeFree.exe") }
end

if node['treesizefree']['shortcut'] == true
	require 'win32ole'
	all_users_desktop = WIN32OLE.new("WScript.Shell").SpecialFolders("AllUsersDesktop")

	windows_shortcut "#{all_users_desktop}/TreeSizeFree.lnk" do
		target "C:\\Program Files\\TreeSizeFree\\TreeSizeFree.exe"
		description "Launch TreeSize Free"
		iconlocation "C:\\Program Files\\TreeSizeFree\\TreeSizeFree.exe, 0"
	end
end
