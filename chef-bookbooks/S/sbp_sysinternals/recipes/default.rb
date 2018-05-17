#
# Cookbook Name:: sbp_sysinternals
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

windows_zipfile node['sysinternals']['install_dir'] do
  source node['sysinternals']['url']
  action :unzip
  not_if { File.exists?("#{node['sysinternals']['install_dir']}/Bginfo.exe") }
end

if !node['sysinternals']['bginfo_config_url'].nil? && !node['sysinternals']['bginfo_config_dir'].nil?
  include_recipe 'sbp_sysinternals::bginfo'
end
