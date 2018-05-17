#
# Cookbook Name:: postgresql_studio
# Recipe:: default
#
# Copyright (C) 2015 computerlyrik, Christian Fischer
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
version = node['postgresql_studio']['version']
unzip_path = "/opt/postgresql_studio"

package "unzip"

ark "postgresql_studio_#{version}" do
  url node['postgresql_studio']['download_url']
  path unzip_path
  extension "zip"
  action :put
end

application 'postgresql_studio' do
  path         '/usr/local/postgresql_studio/'
  java_webapp do
    war '#{unzip_path}/postgresql_studio_#{version}/pgstudio.war'
  end
  tomcat
end
