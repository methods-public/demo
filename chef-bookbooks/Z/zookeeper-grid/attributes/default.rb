#
# Cookbook Name:: zookeeper-grid
# Attributes:: default
#
# Copyright 2013-2017, whitestar
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

# default: for pseudo-replicated
default['zookeeper']['install_flavor'] = 'apache'
default['zookeeper']['version'] = '3.4.5'
default['zookeeper']['archive_url'] = 'http://archive.apache.org/dist/zookeeper'
default['zookeeper']['colo_name'] = 'localhost'
default['zookeeper']['member_of_hadoop'] = false
## run mode: standalone, pseudo-replicated, full-replicated
default['zookeeper']['run_mode'] = 'standalone'
default['zookeeper']['with_security'] = false
default['zookeeper']['realm'] = 'LOCALDOMAIN'
default['zookeeper']['keytab_dir'] = "#{node['grid']['etc_root']}/keytabs/#{node['zookeeper']['colo_name']}"
## zookeeper-env.sh
default['zookeeper']['ZOOKEEPER_PREFIX'] = "#{node['grid']['app_root']}/zookeeper"
default['zookeeper']['ZOO_LOG_DIR_PREFIX'] = "#{node['grid']['vol_root']}/0/var/log/zookeeper"
## zoo.cfg
default['zookeeper']['dataDirPrefix'] = "#{node['grid']['vol_root']}/0/var/lib/zookeeper"
default['zookeeper']['dataLogDir'] = nil
default['zookeeper']['clientPort'] = '2181'
default['zookeeper']['ensemble'] = {
}
default['zookeeper']['tickTime'] = '2000'
default['zookeeper']['initLimit'] = '10'
default['zookeeper']['syncLimit'] = '5'
### if with_security
default['zookeeper']['authProvider'] = {
  '0' => 'org.apache.zookeeper.server.auth.SASLAuthenticationProvider',
}
default['zookeeper']['jaasLoginRenew'] = '3600000'
default['zookeeper']['kerberos.removeHostFromPrincipal'] = 'true'
default['zookeeper']['kerberos.removeRealmFromPrincipal'] = 'true'
## extra settings
default['zookeeper']['extra_configs'] = {
  # e.g. 'zoo.cfg' => {'k1' => 'v1', 'k2' => 'v2'},
  'zookeeper-env.sh' => {},
  'zoo.cfg' => {},
  'java.env' => {},
}
#default['zookeeper'][''] =

=begin
# e.g. for pseudo-replicated
default['zookeeper']['run_mode'] = 'pseudo-replicated'
default['zookeeper']['clientPort'] = '2180'

# e.g. for full-replicated
default['zookeeper']['run_mode'] = 'full-replicated'
default['zookeeper']['colo_name'] = 'colo00'
default['zookeeper']['realm'] = 'GRID.EXAMPLE.COM'
default['zookeeper']['ensemble'] = {
  '0' => {
    :hostname => 'zk00.grid.example.com',
    :leader_port => '2888',
    :election_port => '3888'
  },
  '1' => {
    :hostname => 'zk01.grid.example.com',
    :leader_port => '2888',
    :election_port => '3888'
  },
  '2' => {
    :hostname => 'zk02.grid.example.com',
    :leader_port => '2888',
    :election_port => '3888'
  }
}
=end
