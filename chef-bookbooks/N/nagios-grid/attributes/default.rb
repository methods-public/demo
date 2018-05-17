#
# Cookbook Name:: nagios-grid
# Attributes:: default
#
# Copyright 2016, whitestar
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

default['nagios']['base_cfg_dir'] = 'base'
default['nagios']['site_cfg_dir'] = 'site'
default['nagios']['autostart'] = true
default['nagios']['autoreload'] = true
default['nagios']['with_pnp4nagios'] = false

# nagios.cfg
default['nagios']['check_external_commands'] = '0'
default['nagios']['command_file'] = node.value_for_platform_family(
  'debian' => '/var/lib/nagios3/rw/nagios.cmd',
  'rhel' => '/var/spool/nagios/cmd/nagios.cmd'
)
default['nagios']['use_regexp_matching'] = '0'

# cgi
default['nagios']['cgi'] = {
  'authorized_for_system_information'        => 'nagiosadmin',
  'authorized_for_configuration_information' => 'nagiosadmin',
  'authorized_for_system_commands'           => 'nagiosadmin',
  'authorized_for_all_services'              => 'nagiosadmin',
  'authorized_for_all_hosts'                 => 'nagiosadmin',
  'authorized_for_all_service_commands'      => 'nagiosadmin',
  'authorized_for_all_host_commands'         => 'nagiosadmin',
  'result_limit' => '100',
}

# Web UI
## >= 2.3
default['nagios']['web']['Require'] = [
  'all granted',
]
## < 2.3
default['nagios']['web']['Order'] = 'Allow,Deny'  # e.g. 'Deny,Allow'
default['nagios']['web']['Deny'] = []  # ['From All']
default['nagios']['web']['Allow'] = [
  'From All',
  # e.g.
  #'from 127.0.0.1',
  #'from ::1'
]
## AuthType: 'none'|'Basic'|'Kerberos'
default['nagios']['web']['AuthType'] = 'Basic'
### if AuthType == Basic
default['nagios']['web']['mod_auth_basic']['AuthUserFile'] = node.value_for_platform_family(
  'debian' => '/etc/nagios3/htpasswd.users',
  'rhel'   => '/etc/nagios/passwd'
)
### if AuthType == Kerberos
default['nagios']['web']['mod_auth_kerb']['KrbAuthRealms'] = 'LOCALDOMAIN'
default['nagios']['web']['mod_auth_kerb']['KrbServiceName'] = 'HTTP'
default['nagios']['web']['mod_auth_kerb']['Krb5Keytab'] = '/etc/krb5.keytab'
default['nagios']['web']['mod_auth_kerb']['KrbMethodNegotiate'] = 'on'
default['nagios']['web']['mod_auth_kerb']['KrbMethodK5Passwd'] = 'off'

# objects
## default template base
default['nagios']['objects']['default_contact_groups'] = 'admins'
default['nagios']['objects']['check_ldap'] = {
  'base' => 'dc=example,dc=com',
}
## full customization
default['nagios']['objects']['commands'] = []
default['nagios']['objects']['hosts'] = []
default['nagios']['objects']['hostgroups'] = []
default['nagios']['objects']['hostdependencies'] = []
default['nagios']['objects']['hostescalations'] = []
default['nagios']['objects']['hostextinfos'] = []
default['nagios']['objects']['services'] = []
default['nagios']['objects']['servicegroups'] = []
default['nagios']['objects']['servicedependencies'] = []
default['nagios']['objects']['serviceescalations'] = []
default['nagios']['objects']['serviceextinfos'] = []
default['nagios']['objects']['contacts'] = []
default['nagios']['objects']['contactgroups'] = []
default['nagios']['objects']['timeperiods'] = []

# for check_ganglia_metric
default['nagios']['NagAconda']['version'] = '0.1.4'
#default['nagios']['NagAconda']['version'] = '0.2.1'
default['nagios']['check_ganglia_metric']['enabled'] = false
default['nagios']['check_ganglia_metric']['gmetad_host'] = 'localhost'

# NRPE
default['nagios']['nrpe']['allowed_hosts'] = '127.0.0.1'
default['nagios']['nrpe']['with_smartmontools'] = false
default['nagios']['nrpe']['check_mem.pl'] = {
  'warn' => '80',
  'crit' => '90',
  'extra_opts' => '-u',  # -u|f, -C
}
default['nagios']['nrpe']['check_total_procs'] = {
  'warn' => '100',
  'crit' => '200',
}
(0..3).each {|num|
  default['nagios']['nrpe']["check_disk#{num}"] = {
    'warn' => '20%',
    'crit' => '10%',
    'path' => '/',
    'extra_opts' => '',
  }
}
(0..3).each {|num|
  default['nagios']['nrpe']["check_smart#{num}"] = {
    'device' => '/dev/sda',
  }
}
default['nagios']['nrpe']['check_dig'] = {
  'host' => '127.0.0.1',
  'lookup' => 'host-a.example.com',
}
default['nagios']['nrpe']['check_dig_in'] = {
  'host' => '127.0.0.1',
  'lookup' => 'host-b.example.com',
}
default['nagios']['nrpe']['check_dig_ex'] = {
  'host' => '127.0.0.1',
  'lookup' => 'www.google.com',
}
default['nagios']['nrpe']['check_logs']['log_files'] = [
=begin
  {
    'file_name' => '/var/log/messages',
    'reg_exp' => '(WARNING|CRITICAL)',
    'lines' => 2,               #optional number of output lines  after match
    'new_line_reg_exp' => '^',  #optional new line regex to stop output lines
    'seek_file_suffix' => '2'   #optional seek file suffix
  }
=end
]
