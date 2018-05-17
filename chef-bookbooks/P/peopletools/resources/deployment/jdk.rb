#
# Cookbook Name:: peopletools
# Resource:: jdk
#
# Copyright 2016 University of Derby
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

resource_name :peopletools_jdk
default_action :deploy
property :archive_url, String, required: true
property :deploy_location, String, default: lazy { "/opt/oracle/psft/pt/jdk#{version}" }
property :deploy_user, String, default: 'psadm1'
property :deploy_group, String, default: 'oinstall'
property :version, String, name_property: true

action :deploy do
  # extract jdk archive
  ark ::File.basename(deploy_location) do
    path ::File.dirname(deploy_location)
    url archive_url
    owner deploy_user
    group deploy_group
    strip_components 0
    not_if { ::File.exist?(deploy_location) }
    notifies :run, "ruby_block[chmod_R_#{deploy_location}]", :immediately
    action :put
  end

  # jdk directory permissions
  ruby_block "chmod_R_#{deploy_location}" do
    block do
      FileUtils.chmod_R 0_755, deploy_location
    end
    only_if { ::File.directory?(deploy_location) }
    action :nothing
  end
end
