#
# Copyright (c) 2016 Sam4Mobile, 2017-2018 Make.org
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

cookbook_name = 'ugid-management'

# Enforce UGId Management, ie all users/groups must have a defined uid/gid
default[cookbook_name]['enforce'] = true

# Default shell (enforce /sbin/nologin if not specified)
default[cookbook_name]['default_shell'] = '/sbin/nologin'

# Check if all existing users respect their ugid
default[cookbook_name]['check'] = true

# data bag name for users
default[cookbook_name]['data_bag']['users'] = 'users'

# Whitelist for some system users (typically, systemd users)
default[cookbook_name]['whitelist'] = []

# Output file where errors are pushed (detected by 'check' recipe)
# By default: nil, the recipe raise an exception
default[cookbook_name]['output_file'] = nil

# Configuration of /etc/login.defs
# The following keys are the default for Centos 7
# It is recommended to not set your ugids in the defined ranges
default[cookbook_name]['logindefs'] = {
  'MAIL_DIR' => '/var/spool/mail',
  'PASS_MAX_DAYS' => 99_999,
  'PASS_MIN_DAYS' => 0,
  'PASS_MIN_LEN' => 5,
  'PASS_WARN_AGE' => 7,
  'UID_MIN' => 1000,
  'UID_MAX' => 60_000,
  'SYS_UID_MIN' => 201,
  'SYS_UID_MAX' => 999,
  'GID_MIN' => 1000,
  'GID_MAX' => 60_000,
  'SYS_GID_MIN' => 201,
  'SYS_GID_MAX' => 999,
  'CREATE_HOME' => 'yes',
  'UMASK' => '077',
  'USERGROUPS_ENAB' => 'yes',
  'ENCRYPT_METHOD' => 'SHA512'
}

# Groups to create with their users
default[cookbook_name]['users_manage'] = ['sysadmin']
