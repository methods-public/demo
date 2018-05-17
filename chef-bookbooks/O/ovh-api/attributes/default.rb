#
# Copyright (c) 2015-2017 Sam4Mobile, 2017-2018 Make.org
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

cookbook_name = 'ovh-api'

# Configuration about the encrypted data bag containing the keys
default[cookbook_name]['secrets-data_bag'] = 'secrets'
default[cookbook_name]['ovh-keys'] = 'ovh-keys'

default[cookbook_name]['api-url'] = 'https://api.ovh.com/1.0'

default[cookbook_name]['firewall'] = {
  # '1.2.3.4' => { # you can set it to 'primary' to use server's public ip
  #   'enable' => 'true', # true if not specified, set to false to disable
  #   'rules' => {
  #     '5' => {
  #       'action' => 'permit',
  #       'protocol' => 'tcp',
  #       'tcpOption' => {
  #         'option' => 'established'
  #       }
  #     }
  #   }
  # }
}

# Configure OVH backup
# mount retries and delay (used for convergence in one run)
default[cookbook_name]['backup']['mount_retries'] = 5
default[cookbook_name]['backup']['mount_delay'] = 30
# cifs is enabled by default because it actually works better
default[cookbook_name]['backup']['protos'] = {
  'ftp' => false,
  'nfs' => false,
  'cifs' => true
}

# For nfs and cifs, we can mount it
# Enable if proto is enabled
default[cookbook_name]['backup']['mount']['nfs'] = {
  'owner' => 'root',
  'group' => 'users',
  # do not activate cifs at the same time without changing mount point
  'mount_point' => '/mnt/backup',
  # avoid to be mounted after local_mount_path
  'server_path' => '/export/ftpbackup/',
  'packages' => {
    'centos' => %w[nfs-utils rpcbind],
    'debian' => %w[nfs-client]
  },
  'options' => %w[rw]
}

default[cookbook_name]['backup']['mount']['cifs'] = {
  'owner' => 'root',
  'group' => 'root',
  # do not activate nfs at the same time without changing mount point
  'mount_point' => '/mnt/backup',
  'packages' => {
    'centos' => %w[cifs-utils],
    'debian' => %w[cifs-utils]
  },
  'options' => %w[
    sec=ntlm uid=root gid=root dir_mode=0700 username=root password=
  ]
}
