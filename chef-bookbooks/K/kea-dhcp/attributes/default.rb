#
# Copyright (c) 2015-2016 Sam4Mobile, 2017 Make.org
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

# Set alias for cookbook_name
cookbook_name = 'kea-dhcp'

# Service(s) launched
default[cookbook_name]['services'] = {
  'dhcp4' => false,
  'dhcp6' => false,
  'dhcp-ddns' => false
}

# Default configuration to be set in /etc/kea/kea.conf
#
# It is divided in 3 blocs: Dhcp4, Dhcp6, DhcpDdns and Logging
#
# It is possible to override a configuration key set in an array without having
# to increase the precedence, if it is a Hash or an Array. To do this, use a
# new configuration which share the same first value as the one you want to
# replace.
# For instance, to replace the kea-dhcp4 logger, you can use the following
# attribute (you have to define all subvalues):
# "Logging": {
#   "loggers": [
#     {
#       "name": "kea-dhcp4", # this is the key used for uniqueness
#       "output_options": [
#         {
#           "output": "/var/log/kea-dhcp4-override.log
#         }
#       ],
#       "severity": "DEBUG",
#       "debuglevel": 10
#     }
#   ]
# }
default[cookbook_name]['kea-conf']['Dhcp4'] = {
  'interfaces-config' =>  {
    'interfaces' =>  []
  },
  'lease-database' =>  {
    'type' =>  'memfile'
  },
  'expired-leases-processing' =>  {
    'reclaim-timer-wait-time' =>  10,
    'flush-reclaimed-timer-wait-time' =>  25,
    'hold-reclaimed-time' =>  3_600,
    'max-reclaim-leases' =>  100,
    'max-reclaim-time' =>  250,
    'unwarned-reclaim-cycles' =>  5
  },
  'valid-lifetime' =>  4_000,
  'subnet4' =>  []
}

default[cookbook_name]['kea-conf']['Dhcp6'] = {
  'interfaces-config' =>  {
    'interfaces' =>  []
  },
  'lease-database' =>  {
    'type' =>  'memfile'
  },

  'expired-leases-processing' =>  {
    'reclaim-timer-wait-time' =>  10,
    'flush-reclaimed-timer-wait-time' =>  25,
    'hold-reclaimed-time' =>  3_600,
    'max-reclaim-leases' =>  100,
    'max-reclaim-time' =>  250,
    'unwarned-reclaim-cycles' =>  5
  },
  'preferred-lifetime' =>  3_000,
  'valid-lifetime' =>  4_000,
  'renew-timer' =>  1_000,
  'rebind-timer' =>  2_000,

  'subnet6' =>  []
}

default[cookbook_name]['kea-conf']['DhcpDdns'] = {
  'ip-address' => '127.0.0.1',
  'port' => 53_001,
  'tsig-keys' => [],
  'forward-ddns' => {},
  'reverse-ddns' => {}
}

default[cookbook_name]['kea-conf']['Logging'] = {
  'loggers' => [
    {
      'name' => 'kea-dhcp4',
      'output_options' => [
        {
          'output' => '/var/log/kea-dhcp4.log'
        }
      ],
      'severity' => 'INFO',
      'debuglevel' => 0
    },
    {
      'name' => 'kea-dhcp6',
      'output_options' => [
        {
          'output' => '/var/log/kea-dhcp6.log'
        }
      ],
      'severity' => 'INFO',
      'debuglevel' => 0
    },
    {
      'name' => 'kea-dhcp-ddns',
      'output_options' => [
        {
          'output' => '/var/log/kea-ddns.log'
        }
      ],
      'severity' => 'INFO',
      'debuglevel' => 0
    }
  ]
}

# Configuration for network-interface
default[cookbook_name]['network-interface'] = []

# Path where to put network configuration
default[cookbook_name]['config-path'] = '/etc/sysconfig/network-scripts'

# Add those routes after network initialization
default[cookbook_name]['routes'] = []

# Specific configuration depending on status (client or server)
default[cookbook_name]['client-config'] = {}
default[cookbook_name]['server-config'] = {}

# Mostly useful for tests
default[cookbook_name]['package_retries'] = nil
