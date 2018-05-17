#
# Copyright (c) 2017 Make.org
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

# Create rundeck cluster directory
directory "#{node['rundeck_server']['confdir']}/nodes" do
  recursive true
  mode '0755'
end

# Deploy rundeck cluster files configuration
::Chef::Recipe.send(:include, ClusterSearch)
header = "# Produced by Chef -- changes will be overwritten\n"

node[cookbook_name]['nodes_roles'].each do |role, remote_user|
  cluster = cluster_search('role' => role)
  next if cluster.nil? || cluster['hosts'].empty?

  content = cluster['hosts'].map do |fqdn|
    [fqdn, {
      'hostname' => fqdn,
      'nodename' => fqdn,
      'username' => remote_user
    }]
  end

  file "#{node['rundeck_server']['confdir']}/nodes/#{role}.yml" do
    content "#{header}\n#{content.to_h.to_yaml}"
    mode '0755'
  end
end
