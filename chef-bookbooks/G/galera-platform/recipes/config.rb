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

# Use ClusterSearch
::Chef::Recipe.send(:include, ClusterSearch)

# Looking for members of cluster
cluster = cluster_search(node['galera-platform'])
return if cluster.nil? # return (wait for next run) if we found nothing

# Check if initiator_id is a correct value
initiator_id = node['galera-platform']['initiator_id']
if initiator_id < 1 || initiator_id > cluster['hosts'].size
  raise 'Invalid initiator_id, should be between 1 and cluster.size'
end

raise 'Cannot find myself in the cluster' if cluster['my_id'] == -1

# Main configuration
config = node['galera-platform']['config'].to_hash

# Load root password from encrypted data bag
data_bag = node['galera-platform']['data_bag']
root_pw = data_bag_item(
  data_bag['name'],
  data_bag['item']
)[data_bag['key']]

config['wsrep_sst_auth'] = "root:#{root_pw}"

# Build the cluster address
config['wsrep_cluster_address'] = "gcomm://#{cluster['hosts'].join(',')}"

config['wsrep_node_address'] = node['fqdn']

# Deploy config
template '/etc/my.cnf.d/server.cnf' do
  variables config: config
  source 'server.cnf.erb'
  owner 'root'
  group 'mysql'
  mode '0640'
end

# Set the root password (auto-login)
template '/root/.my.cnf' do
  source 'my.cnf.erb'
  mode '0640'
  owner 'root'
  group 'root'
  variables 'password' => root_pw
  action :create_if_missing
end if node['galera-platform']['root_autologin']

# Bootstrap has to be executed only on the first node of cluster
if cluster['my_id'] == initiator_id
  execute 'cluster-bootstrap' do
    command <<-EOF
      galera_new_cluster && \
      touch /etc/my.cnf.d/cluster_bootstraped
    EOF
    creates '/etc/my.cnf.d/cluster_bootstraped'
  end

  # Secure installation
  # For commodity we allow root user to connect from any host
  execute 'secure galera installation' do
    command <<-EOF
      mysql -u root -p'' \
      -e "UPDATE mysql.user SET Password=PASSWORD('#{root_pw}') \
      WHERE User='root'; \
      DELETE FROM mysql.user WHERE User=''; \
      DROP DATABASE test; \
      DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'; \
      UPDATE mysql.user SET Host='%' WHERE Host='#{node['fqdn']}'; \
      FLUSH PRIVILEGES;" && touch /etc/my.cnf.d/installation_secured
    EOF
    creates '/etc/my.cnf.d/installation_secured'
  end
else
  # Check if initiator has bootstraped and create a file in this case
  retry_number = node['galera-platform']['bootstrap_check_retry_number']
  execute 'check bootstrap status on initiator' do
    command <<-EOF
    for (( try=1; try<=#{retry_number}; try++ )); do
      mysql --connect_timeout 2 \
      -h #{cluster['hosts'][initiator_id - 1]} -u root -p#{root_pw} \
      -e "use mysql;" \ >/dev/null 2>&1 \
      && touch /etc/my.cnf.d/cluster_bootstraped
      if [ -e /etc/my.cnf.d/cluster_bootstraped ]; then
        break
      fi
      sleep 5
    done
    true
    EOF
    creates '/etc/my.cnf.d/cluster_bootstraped'
    ignore_failure true
  end
end
