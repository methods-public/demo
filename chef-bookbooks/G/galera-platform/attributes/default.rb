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

# Configuration about the encrypted data bag containing the keys
default['galera-platform']['data_bag']['name'] = 'secrets'
default['galera-platform']['data_bag']['item'] = 'mariadb-credentials'
# Key used to load the value in data bag containing the password
default['galera-platform']['data_bag']['key'] = 'password'

# Cluster configuration with cluster-search
# Role used by the search to find other nodes of the cluster
default['galera-platform']['role'] = 'galera-platform'
# Hosts of the cluster, deactivate search if not empty
default['galera-platform']['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default['galera-platform']['size'] = 3

# Initiator id define the node that will perform cluster creation
default['galera-platform']['initiator_id'] = 1

# Default yum repository url for DB backend
default['galera-platform']['repo_url'] =
  'http://yum.mariadb.org/10.2/centos7-amd64/'
# GPG key associated to DB backend repository
default['galera-platform']['repo_gpgkey'] =
  'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'

# Packages to install
default['galera-platform']['package'] = 'mariadb-server'

# SST is the method used by the cluster to provisions nodes by
# transferring a full data copy from one node to another.
# xtrabackup method is the preferred method as it is non-blocking (it does not
# require to put donor in read-only).
# rsync method works also and does not require to install additional packages.
default['galera-platform']['sst_method'] = 'xtrabackup'

# Default yum repository url for Percona
default['galera-platform']['percona']['repo_url'] =
  'http://repo.percona.com/release/$releasever/RPMS/$basearch'

# GPG key associated to Percona repository
default['galera-platform']['percona']['repo_gpgkey'] =
  'https://www.percona.com/downloads/percona-release/RPM-GPG-KEY-percona'

# Package to install if sst method is set to xtrabackup
default['galera-platform']['percona']['xtrabackup']['package'] =
  'percona-xtrabackup-24'

# MariaDB global cluster node configuration
default['galera-platform']['config'] = {
  'wsrep_on' => 'ON',
  'wsrep_provider' => '/usr/lib64/galera/libgalera_smm.so',
  'binlog_format' => 'row',
  'default_storage_engine' => 'InnoDB',
  'innodb_autoinc_lock_mode' => '2',
  'bind-address' => '0.0.0.0',
  'wsrep_cluster_name' => 'MariaDB_Cluster',
  'wsrep_sst_method' => node['galera-platform']['sst_method'],
  'datadir' => '/var/lib/mysql'
}

# Deploy password for root user to allow easy db login
default['galera-platform']['root_autologin'] = true

# Auto restart when configuration files change
default['galera-platform']['auto_restart'] = false

# Configure retries for galera backend service
# retry if no donors are available to provide the initial dump through the
# configured sst_method
default['galera-platform']['service']['retries_number'] = nil
default['galera-platform']['service']['retry_delay'] = nil

# Numbers of connection attempts to check if initiator has bootstrapped
default['galera-platform']['bootstrap_check_retry_number'] = 1

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default['galera-platform']['package_retries'] = nil
