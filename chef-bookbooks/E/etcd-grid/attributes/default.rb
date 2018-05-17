#
# Cookbook Name:: etcd-grid
# Attributes:: default
#
# Copyright 2017, whitestar
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

#default['etcd-grid']['with_ssl_cert_cookbook'] = false
# If ['etcd-grid']['with_ssl_cert_cookbook'] is true,
# node['etcd-grid']['docker-compose']['config']
# are overridden by the following 'common_name' attributes.
#default['etcd-grid']['ssl_cert']['common_name'] = node['fqdn']

default['etcd-grid']['image']['url'] = 'quay.io/coreos/etcd'
default['etcd-grid']['image']['version'] = 'v3.1'
default['etcd-grid']['cluster']['size'] = 3  # recommended: 3, 5, 7
default['etcd-grid']['node']['port4client'] = '2379'
default['etcd-grid']['node']['port4peer'] = '2380'
default['etcd-grid']['docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/etcd"
default['etcd-grid']['docker-compose']['data_dir'] = "#{node['etcd-grid']['docker-compose']['app_dir']}/data"

image = "#{node['etcd-grid']['image']['url']}:#{node['etcd-grid']['image']['version']}"
cluster_size = node['etcd-grid']['cluster']['size'].to_i
port4client = node['etcd-grid']['node']['port4client']
port4peer = node['etcd-grid']['node']['port4peer']
data_dir = node['etcd-grid']['docker-compose']['data_dir']

nodes = []
services = {}

(1..cluster_size).each {|num|
  nodes.push("node#{num}=http://etcd#{num}:#{port4peer}")
}

(1..cluster_size).each {|num|
  services["etcd#{num}"] = {
    'image' => image,
    'restart' => 'always',
    'ports' => [
      #"#{port4client}#{num}:#{port4client}",
      #"#{port4peer}#{num}:#{port4peer}",
    ],
    'environment' => {
      'ETCD_NAME' => "node#{num}",
      'ETCD_DATA_DIR' => "node#{num}.etcd",
      'ETCD_LISTEN_CLIENT_URLS'          => "http://etcd#{num}:#{port4client},http://localhost:#{port4client}",
      'ETCD_ADVERTISE_CLIENT_URLS'       => "http://etcd#{num}:#{port4client}",
      'ETCD_LISTEN_PEER_URLS'            => "http://etcd#{num}:#{port4peer}",
      'ETCD_INITIAL_ADVERTISE_PEER_URLS' => "http://etcd#{num}:#{port4peer}",
      'ETCD_INITIAL_CLUSTER' => nodes.join(','),
      'ETCD_INITIAL_CLUSTER_TOKEN' => 'etcd-test-token',  # TODO: stored in Vault.
      'ETCD_INITIAL_CLUSTER_STATE' => 'new',
      'ETCDCTL_API' => '3',
    },
    'volumes' => [
      "#{data_dir}/node#{num}.etcd:/node#{num}.etcd:rw",
    ],
  }
}

force_override['etcd-grid']['docker-compose']['config_format_version'] = '2'
version_2_config = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => services,
}

default['etcd-grid']['docker-compose']['config'] = version_2_config
