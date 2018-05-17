#
# Cookbook Name:: auditbeat
# Recipe:: default
#
# Copyright 2017, Virender Khatri
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

include_recipe 'auditbeat::attributes'

# install auditbeat
case node['platform']
when 'windows'
  include_recipe 'auditbeat::install_windows'
else
  if node['auditbeat']['version'].scan(/beta|alpha/).empty?
    include_recipe 'yum-plugin-versionlock::default' if node['platform_family'] == 'rhel'
    include_recipe 'auditbeat::install_package'
  else
    include_recipe 'auditbeat::install_package_preview'
  end
end

# configure auditbeat
include_recipe 'auditbeat::config'
