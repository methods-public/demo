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

my_spark_id = node.run_state['spark-platform']['spark_cluster']['my_id']
master_id = node['spark-platform']['master_id']
n_of_masters = node['spark-platform']['n_of_masters']
masters = master_id..(master_id + n_of_masters - 1)
iam_master = masters.include? my_spark_id

if node['spark-platform']['auto_restart']
  config_files = [
    "#{node['spark-platform']['prefix_home']}/spark/conf/spark-env.sh",
    "#{node['spark-platform']['prefix_home']}/spark/conf/spark-defaults.conf",
    "#{node['spark-platform']['prefix_home']}/spark/conf/log4j.properties"
  ].map do |path|
    "template[#{path}]"
  end
else config_files = []
end

# Start master only if node have the master id of the cluster or if node is in
# a standby master mode with ZooKeeper
service 'spark-master' do
  action [:enable, :start]
  subscribes :restart, config_files if node['spark-platform']['auto_restart']
  only_if { iam_master }
end

# Start worker
service 'spark-worker' do
  action [:enable, :start]
  only_if { node['spark-platform']['master_is_worker'] || !iam_master }
end
