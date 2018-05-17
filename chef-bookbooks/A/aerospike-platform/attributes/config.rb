#
# Copyright (c) 2016 Sam4Mobile, 2018 Make.org
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

cookbook_name = 'aerospike-platform'
root_prefix = node[cookbook_name]['prefix_root']

default[cookbook_name]['config'] = {
  'service' => {
    'user' => node[cookbook_name]['user'],
    'group' => node[cookbook_name]['group'],
    'run-as-daemon' => '',
    'paxos-single-replica-limit' => 1,
    'pidfile' => "#{root_prefix}/aerospike/var/run/aerospike.pid",
    'transaction-queues' => 8,
    'transaction-threads-per-queue' => 8,
    'proto-fd-max' => 15_000,
    'work-directory' => "#{root_prefix}/aerospike/var"
  },
  'logging' => {
    "file #{root_prefix}/aerospike/var/log/aerospike.log" => {
      'context' => 'any info'
    }
  },
  'mod-lua' => {
    'system-path' => "#{root_prefix}/aerospike/share/udf/lua",
    'user-path' => "#{root_prefix}/aerospike/var/udf/lua"
  },
  'network' => {
    'service' => {
      'address' => 'any',
      'port' => 3000
    },
    'heartbeat' => {
      'mode' => 'mesh',
      'address' => node['ipaddress'],
      'port' => 8002,
      'interval' => 150,
      'timeout' => 20
    },
    'fabric' => {
      'port' => 7001
    },
    'info' => {
      'port' => 7002
    }
  }
}
