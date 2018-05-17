#
# Copyright (c) 2016 Sam4Mobile
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

# Generate config
config_path = "#{node['spark-platform']['prefix_home']}/spark/conf"
# Get spark-env parameters
spark_env = node['spark-platform']['spark-env.sh'].to_hash
spark_env['SPARK_LOCAL_DIRS'] = node['spark-platform']['local_dir']
spark_env['SPARK_MASTER_PORT'] = node['spark-platform']['master_port']

# "Scratch" space, map output files and RDDs will be stored under this dir
directory node['spark-platform']['local_dir'] do
  owner node['spark-platform']['user']
  group node['spark-platform']['group']
  mode '0775'
  action :create
end

# Log4j default config file, fetch it directly from github
version = node['spark-platform']['version']
github = node['spark-platform']['github']
::Chef::Recipe.send(:require, 'net/http')
properties_file = "#{github}/v#{version}/conf/log4j.properties.template"
properties = ::Net::HTTP.get(URI(properties_file))
lines = properties.lines.reject do |line|
  line.match(/^#/)
end.map(&:chomp).reject(&:empty?)
default_log4j = lines.map do |line|
  key, *value = line.split('=')
  { key => value.join('=') }
end.inject(:merge)
user_log4j = node['spark-platform']['log4j']

# Deploy config files
{
  'spark-env.sh' => spark_env,
  'spark-defaults.conf' => node['spark-platform']['spark-defaults.conf'],
  'log4j.properties' => default_log4j.merge(user_log4j)
}.each_pair do |file, config|
  template "#{config_path}/#{file}" do
    variables config: config
    mode '0644'
    source "spark/#{file}.erb"
  end
end

# Use ClusterSearch
::Chef::Recipe.send(:include, ClusterSearch)

# Create empty hash for run_state attributes used in other recipes
node.run_state['spark-platform'] = {}

# Looking for members of Spark cluster
spark_cluster = cluster_search(node['spark-platform'])
return if spark_cluster.nil? # return (wait for next run) if we found nothing

# Save the found cluster to run_state to make it accessible to other recipes
node.run_state['spark-platform']['spark_cluster'] = spark_cluster

m_id = node['spark-platform']['master_id']
m_index = node['spark-platform']['master_id'] - 1
n_of_masters = node['spark-platform']['n_of_masters']

# Determine master ids
if m_id + n_of_masters - 1 > spark_cluster['hosts'].size
  raise 'Invalid master_id, should be between 1 and cluster.size'
end
raise 'Cannot find myself in the cluster' if spark_cluster['my_id'] == -1

if node['spark-platform']['master_ha_with_zk']
  # Build master url if master HA with Zookeeper is enabled
  master_port = node['spark-platform']['master_port']
  cluster = spark_cluster['hosts'].map { |host| host + ':' + master_port }
  cluster = cluster[m_index..(m_index + n_of_masters - 1)]

  node.run_state['spark-platform']['master_url'] =
    "spark://#{cluster.join(',')}"

  # Looking for members of ZooKeeper cluster
  zookeeper = cluster_search(node['spark-platform']['zookeeper'])
  return if zookeeper.nil? # Not enough nodes

  zk = zookeeper['hosts'].map do |host|
    "#{host}:2181"
  end.join(',')

  # Master will connect to the ZooKeeper cluster for enabling HA
  spark_env['SPARK_DAEMON_JAVA_OPTS'] =
    '"-Dspark.deploy.recoveryMode=ZOOKEEPER'\
    " -Dspark.deploy.zookeeper.url=#{zk}\""
else
  # Determine master url if HA is deactivated
  spark_master_host = spark_cluster['hosts'][m_index]
  spark_master_port = node['spark-platform']['master_port']
  node.run_state['spark-platform']['master_url'] =
    "spark://#{spark_master_host}:#{spark_master_port}"
end
