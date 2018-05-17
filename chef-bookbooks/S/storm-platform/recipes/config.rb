#
# Copyright (c) 2015-2016 Sam4Mobile
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

# Initialize run_state
run_state = node.run_state['storm-platform'] || {}

# Search for Zookeeper
::Chef::Recipe.send(:include, ClusterSearch)
zookeeper_cluster = cluster_search(node['storm-platform']['zookeeper'])
return if zookeeper_cluster.nil?

# Get other storm nodes
storm_home = "#{node['storm-platform']['prefix_home']}/storm"
config = node['storm-platform']['config'].to_hash
config['storm.zookeeper.servers'] = zookeeper_cluster['hosts']

storm_cluster = cluster_search(node['storm-platform'])
return if storm_cluster.nil?

nimbus_id = node['storm-platform']['nimbus_id']
n_of_nimbus = node['storm-platform']['n_of_nimbus']
cluster_size = storm_cluster['hosts'].size
range = nimbus_id..(nimbus_id + n_of_nimbus - 1)

if nimbus_id < 1 || nimbus_id + n_of_nimbus - 1 > cluster_size
  raise "Invalid nimbus range (#{range}) for a #{cluster_size} nodes cluster"
end
raise 'Cannot find myself in the cluster' if storm_cluster['my_id'] == -1

# Get all nimbus
run_state['iam_nimbus'] = range.include? storm_cluster['my_id']
run_state['nimbus_ha'] = n_of_nimbus > 1
config['nimbus.seeds'] = range.map { |i| storm_cluster['hosts'][i - 1] }

ports = node['storm-platform']['slots_ports'].to_a
config['supervisor.slots.ports'] = ports unless ports.empty?

# Create work directories
[
  node['storm-platform']['log_dir'],
  node['storm-platform']['data_dir']
].each do |path|
  directory path do
    owner node['storm-platform']['user']
    group node['storm-platform']['user']
    mode '0755'
    recursive true
    action :create
  end
end

# Link storm.home/logs to log_dir (hardcoded in storm code)
link "#{storm_home}/logs" do
  to node['storm-platform']['log_dir']
end

# Generate the general storm config in two steps
# 1/ Create a template to be able to use chef variables
template "#{storm_home}/conf/storm.yaml.erb" do
  source 'yaml.erb'
  mode 0644
  variables config: config
end

# 2/ Interpret the second template to generate the final config
template "#{storm_home}/conf/storm.yaml" do
  source "#{storm_home}/conf/storm.yaml.erb"
  local true
  mode 0644
end

# Log4j2 config files
version = node['storm-platform']['version']
github = node['storm-platform']['github']
chef_gem 'xml-simple'
::Chef::Recipe.send(:require, 'xmlsimple')
::Chef::Recipe.send(:require, 'net/http')

%w(cluster worker).each do |entity|
  xml_file = "#{github}/v#{version}/log4j2/#{entity}.xml"
  xml_string = ::Net::HTTP.get(URI(xml_file))
  default_log4j2 = ::XmlSimple.xml_in(xml_string)
  user_log4j2 = node['storm-platform']['log4j'][entity]

  template "#{storm_home}/log4j2/#{entity}.xml" do
    variables config: { configuration: default_log4j2.merge(user_log4j2) }
    mode '0644'
    source 'xml.erb'
  end
end

# Save run_state
node.run_state['storm-platform'] = run_state
