#
# Copyright (c) 2016-2017 Sam4Mobile, 2017-2018 Make.org
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

cookbook_name = 'docker-platform'

### Docker daemon

# Package and repository stuff
default[cookbook_name]['version'] = 'latest'
default[cookbook_name]['package_name'] = 'docker-ce'

default[cookbook_name]['repo']['name'] = 'docker-ce-stable'
default[cookbook_name]['repo']['description'] = 'Docker CE Stable'
default[cookbook_name]['repo']['url'] =
  'https://download.docker.com/linux/centos/7/$basearch/stable'
default[cookbook_name]['repo']['gpgkey'] =
  'https://download.docker.com/linux/centos/gpg'

# Configuration directory
default[cookbook_name]['config_dir'] = '/etc/docker'

# Certificates dir, default in /root because docker use it by default
default[cookbook_name]['certs_dir'] = '/root/.docker'

# Docker configuration (daemon.json in configuration directory)
default[cookbook_name]['config'] = {}

# Port for Docker daemon to listen
# Note: it is automatically enabled if TLS is activate, aka if data_bag item
#       is not nil, and unix socket will still be activated
# You can override this by setting 'config' attribute
default[cookbook_name]['port'] = 2376

# Name and item of the encrypted data bag containing the certs used for TLS
# IMPORTANT:
#   - inside an item, the key must be ca, cert and key.
#   - if item is non-nil, tls will be enabled and corresponding options will
#     be added in daemon.json configuration
default[cookbook_name]['data_bag']['name'] = 'secrets'
default[cookbook_name]['data_bag']['item'] = nil

# Systemd unit configuration (used for overriding the default)
# WARN: you should always indent multiline clause like ExecStart
default[cookbook_name]['systemd_unit'] = {}
default[cookbook_name]['systemd_unit_path'] = '/etc/systemd/system'

# Do we do a full override? (like systemctl edit --full)
default[cookbook_name]['unit_full_override'] = false

# Docker binary
default[cookbook_name]['bin'] = '/bin/docker'

### Resources

# Create docker networks
default[cookbook_name]['networks'] = {}

# Create docker swarm services
default[cookbook_name]['services'] = {}

# For other resources, look at docker cookbook

### Swarm

# Is it enabled?
default[cookbook_name]['swarm']['enabled?'] = false

# Cluster configuration with cluster-search
# Role used by the search to find the managers of the cluster
default[cookbook_name]['swarm']['role'] = "#{cookbook_name}-swarm-manager"
# Hosts of the cluster, deactivate search if not empty
default[cookbook_name]['swarm']['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default[cookbook_name]['swarm']['size'] = 1

# Samething but to find the consul cluster
default[cookbook_name]['swarm']['consul']['role'] = 'consul'
default[cookbook_name]['swarm']['consul']['hosts'] = []
default[cookbook_name]['swarm']['consul']['size'] = 1
# Consul port
default[cookbook_name]['swarm']['consul']['port'] = 8500

# Options for nodes joining the swarm, used also if initializing it
default[cookbook_name]['swarm']['join_opts'] = {}
# Specific options when initiating the swarm
default[cookbook_name]['swarm']['init_opts'] = {}

# How many times we retry to join a cluster
# Quite high numbers but we do not retry at all in swarm resource
default[cookbook_name]['swarm']['join_retry_number'] = 5
default[cookbook_name]['swarm']['join_retry_delay'] = 5

### Misc

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
