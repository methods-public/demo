#
# Cookbook Name:: nsca
# Attributes:: default
#
# Copyright 2015 Andrei Skopenko
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

# password data bag
# set data bag item or attribute for password
default['nsca']['data_bag'] = 'apps'
default['nsca']['data_bag_item'] = 'nsca'
default['nsca']['password'] = 'password'

# config file options
default['nsca']['pid_file'] = '/var/run/nsca.pid'
default['nsca']['server_address'] = nil
default['nsca']['nsca_chroot'] = nil
default['nsca']['server_port'] = 5667
default['nsca']['debug'] = 0
default['nsca']['aggregate_writes'] = 0
default['nsca']['append_to_file'] = 0
default['nsca']['max_packet_age'] = 30
default['nsca']['decryption_method'] = 1

# platform specific options
case node['platform_family']
when 'debian'
  default['nsca']['conf_dir'] = '/etc'
  default['nsca']['user'] = 'nobody'
  default['nsca']['group'] = 'nogroup'
  default['nsca']['mode'] = '0640'
  default['nsca']['command_file'] = '/var/lib/nagios3/rw/nagios.cmd'
  default['nsca']['alternate_dump_file'] = '/var/run/nagios/nsca.dump'
when 'rhel', 'fedora'
  default['nsca']['conf_dir'] = '/etc/nagios'
  default['nsca']['user'] = 'nagios'
  default['nsca']['group'] = 'nagios'
  default['nsca']['mode'] = '0644'
  default['nsca']['command_file'] = '/var/spool/nagios/cmd/nagios.cmd'
  default['nsca']['alternate_dump_file'] = '/var/spool/nagios/cmd/nsca.dump'
end
