# Cookbook Name:: wlp
# Attributes:: default
#
# (C) Copyright IBM Corporation 2013.
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

action :download do

  liberty_repository = node[:wlp][:repository][:liberty]
  repository_urls = node[:wlp][:repository][:urls]

  directory "#{node[:wlp][:base_dir]}/wlp/etc" do
    owner node[:wlp][:user]
    group node[:wlp][:group]
    mode '0755'
    action :create
  end

  properties = ""

  if liberty_repository == false
    properties = "useDefaultRepository=false \n"
  else
    properties = "useDefaultRepository=true \n"
  end

  if repository_urls != []
    repository_urls.each_with_index do |url, index|
      properties << "repository#{index}.url=#{url} \n"
    end
  end

  file "#{node[:wlp][:base_dir]}/wlp/etc/repositories.properties" do
    content "#{properties}"
    owner 'wlp'
    group 'wlpadmin'
    mode '0644'
    action :create
  end

  if new_resource.directory == nil
    directory = node[:wlp][:base_dir]
  else
    directory = new_resource.directory
  end

  if new_resource.name =~ /:\/\//
    name_uri = ::URI.parse(new_resource.name)
    name_filename = ::File.basename(name_uri.path)
    name = "#{Chef::Config[:file_cache_path]}/#{name_filename}"
    remote_file name do
      source new_resource.name
      user node[:wlp][:user]
      group node[:wlp][:group]
    end
  else
    name = new_resource.name
  end
  command = "#{@utils.installDirectory}/bin/installUtility download"
  command << " --location=#{directory}"
  if new_resource.accept_license
    command << " --acceptLicense"
  end
  command << " #{name}"
  execute command do
    command command
    user node[:wlp][:user]
    group node[:wlp][:group]
    returns [0, 22]
  end
end

private

def load_current_resource
  @utils = Liberty::Utils.new(node)
end
