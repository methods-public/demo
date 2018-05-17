#
# Cookbook Name:: patchman
# Default:: default
#
# Copyright 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# determine what environment current node resides and set ['patchman']['environment'] variable.
if node['patchman']['test']['define'].include? node.chef_environment
  node.default['patchman']['environment'] = 'test'
elsif node['patchman']['prod']['define'].include? node.chef_environment
  node.default['patchman']['environment'] = 'prod'
else
  log "Unable to determine environment so setting ['patchman']['environment'] to 'prod'" do
    level :warn
  end
  node.default['patchman']['environment'] = 'prod'
end

case node['platform_family']
when 'debian'
  include_recipe 'patchman::debian'
when 'rhel'
  include_recipe 'patchman::rhel'
else
  log 'Not able to locate supported OS' do
    level :warn
  end
end
