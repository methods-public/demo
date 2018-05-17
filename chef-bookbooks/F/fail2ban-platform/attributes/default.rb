#
# Copyright (c) 2018 Make.org
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

cookbook_name = 'fail2ban-platform'

# Packages to install
default[cookbook_name]['packages'] = {
  'centos' => %w[fail2ban-server fail2ban-sendmail]
}

# Fail2Ban configuation directory
default[cookbook_name]['config_dir'] = '/etc/fail2ban'

# Fail2Ban configuration
#
# Each hash key represents a custom configuration fail2ban directory
#
# Assign it an hash respecting this pattern:
# - Top keys are filename
# - Sub hash represents an INI configuration where hash keys are sections
#
# Here's an example to enable fail2ban on SSH:
# {
#   jail => { # jail.d custom configuration directory
#     'sshd.conf' => # filename inside directory
#       'sshd' => { # INI section
#         'enabled' => 'true' # INI key
#       }
#     }
#   }
# }
#
# No configuration override is done by default leaving the configuration
# embedded with package
#
# See .kitchen.yml for more examples

default[cookbook_name]['config'] = {
  'action' => nil,
  'fail2ban' => nil,
  'filter' => nil,
  'jail' => nil
}

# Systemd service unit
default[cookbook_name]['systemd_unit'] = {
  'Unit' => {
    'Description' => 'Fail2Ban Service',
    'After' => 'network.target iptables.service',
    'PartOf' => ''
  },
  'Service' => {
    'Type' => 'forking',
    'ExecStart' => '/usr/bin/fail2ban-client -x start',
    'ExecStop' => '/usr/bin/fail2ban-client stop',
    'ExecReload' => '/usr/bin/fail2ban-client reload',
    'PIDFile' => '/var/run/fail2ban/fail2ban.pid',
    'Restart' => 'always'
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}

# If Fail2Ban service is restarted when config file changes
default[cookbook_name]['auto_restart'] = true

# Configure retries for thes package resources, d
# (mostly used for test purpose)
default[cookbook_name]['package_retries'] = nil
