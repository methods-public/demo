#
# Cookbook Name:: coopr
# Recipe:: server
#
# Copyright © 2013-2014 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'coopr::default'

# We require Java
include_recipe 'java'
log 'java-home' do
  message "JAVA_HOME = #{node['java']['java_home']}"
end
ENV['JAVA_HOME'] = node['java']['java_home']

package 'coopr-server' do
  action :install
end

execute 'copy logback.xml from coopr conf.dist' do
  command "cp /etc/coopr/conf.dist/logback.xml /etc/coopr/#{node['coopr']['conf_dir']}"
  not_if { ::File.exist?("/etc/coopr/#{node['coopr']['conf_dir']}/logback.xml") }
end

service 'coopr-server' do
  status_command 'service coopr-server status'
  action :nothing
end
