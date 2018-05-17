#
# Copyright (c) 2017-2018 Make.org
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

cookbook_name = 'iptables-services'

default[cookbook_name]['services'] = {
  'iptables' => true,
  'ip6tables' => true
}

# Defaults are for rhel, auto-update should be safe
default[cookbook_name]['package'] = 'iptables-services'
default[cookbook_name]['auto_update'] = true
default[cookbook_name]['config_path'] = '/etc/sysconfig'
default[cookbook_name]['config_suffix'] = '-config'

# Services config
default[cookbook_name]['iptables']['config'] = {
  'IPTABLES_MODULES' => '',
  'IPTABLES_MODULES_UNLOAD' => 'yes',
  'IPTABLES_SAVE_ON_STOP' => 'yes', # package default is no
  'IPTABLES_SAVE_ON_RESTART' => 'yes', # package default is no
  'IPTABLES_SAVE_COUNTER' => 'yes', # package default is no
  'IPTABLES_STATUS_NUMERIC' => 'yes',
  'IPTABLES_STATUS_VERBOSE' => 'no',
  'IPTABLES_STATUS_LINENUMBERS' => 'yes'
}

default[cookbook_name]['ip6tables']['config'] = {
  'IP6TABLES_MODULES' => '',
  'IP6TABLES_MODULES_UNLOAD' => 'yes',
  'IP6TABLES_SAVE_ON_STOP' => 'yes', # package default is no
  'IP6TABLES_SAVE_ON_RESTART' => 'yes', # package default is no
  'IP6TABLES_SAVE_COUNTER' => 'yes', # package default is no
  'IP6TABLES_STATUS_NUMERIC' => 'yes',
  'IP6TABLES_STATUS_VERBOSE' => 'no',
  'IP6TABLES_STATUS_LINENUMBERS' => 'yes'
}

# Define groups of nodes to which we want to apply the same rule, for instance,
#   if we want to whitelist a port only for members of a given role
# Here, we only define groups based on search criteria. Groups will be used in
#   tables configuration, where a rule will be created for each member of a
#   group, replacing %group_name pattern by each member
# We use cluster-search cookbook to help us
default[cookbook_name]['groups'] = {
  # "group_name" => {
  #   # Role used by search to find nodes, probably the only argument you need
  #   role => 'some_role',
  #   # Static list of cluster members: deactivate search if not empty
  #   # You have to choose between role and hosts
  #   hosts => [],
  #   # Expected size of the cluster. Ignored if nil/0 or if hosts is not empty
  #   # default is nil
  #   size => 0,
  #   # List of attributes to dig to get the ipaddress we want
  #   # default is below
  #   attributes => ['ipaddress'],
  # }
}

# Tables configuration
default[cookbook_name]['iptables']['tables'] = {
  #  'filter' => {
  #    'INPUT' => {
  #      'ACCEPT': 0, # special case: chain policy, should be first in priority
  #      '-m state --state ESTABLISHED -j ACCEPT': 1 # priority, not rule id
  #      '-s %{group_name} -j ACCEPT': 98 # %{} is for using a group
  #    },
  #    'FORWARD' => {
  #      'DROP': 0
  #    },
  #    'MANAGED-EXTERNALLY' => 'undefined', # only create the chain (if needed)
  #    'USER-DEFINED' => {
  #      '-j ACCEPT': 2
  #    }
  #  }
}

default[cookbook_name]['ip6tables']['tables'] = {}

# Configure retries for the package resources, default = global default (0)
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
