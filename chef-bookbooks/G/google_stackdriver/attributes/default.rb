# Cookbook Name:: google_stackdriver
# Attributes:: default
#
# Copyright (C) 2013-2014 TABLE_XI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

default['google_stackdriver']['action'] = :upgrade
default['google_stackdriver']['api_key'] = nil
default['google_stackdriver']['config_collectd'] = true
default['google_stackdriver']['enable'] = true
default['google_stackdriver']['gen_hostid'] = false
default['google_stackdriver']['gpg_key'] = 'https://app.stackdriver.com/RPM-GPG-KEY-stackdriver'
default['google_stackdriver']['service_account']['file_provided'] = false
default['google_stackdriver']['service_account']['client_email'] = nil
default['google_stackdriver']['service_account']['client_id'] = nil
default['google_stackdriver']['service_account']['client_x509_cert_url'] = nil
default['google_stackdriver']['service_account']['private_key'] = nil
default['google_stackdriver']['service_account']['private_key_id'] = nil
default['google_stackdriver']['service_account']['project_id'] = nil
default['google_stackdriver']['service_account']['x509_cert_url'] = nil
default['google_stackdriver']['tags'] = {}

case node['platform']
when 'amazon'
  default['google_stackdriver']['repo_url'] =
    if node['platform_version'].to_f > 2012.09
      'http://repo.stackdriver.com/repo/amzn-2014.03/$basearch/'
    else
      'http://repo.stackdriver.com/repo/el6/$basearch/'
    end
  default['google_stackdriver']['config_path'] = '/etc/sysconfig/stackdriver'
when 'centos', 'redhat', 'scientific' # ~FC024 because amazon is specified in the previous case
  default['google_stackdriver']['repo_url'] = "http://repo.stackdriver.com/repo/el#{node['platform_version'].to_i}/$basearch/"
  default['google_stackdriver']['config_path'] = '/etc/sysconfig/stackdriver'
when 'ubuntu'
  default['google_stackdriver']['repo_dist'] = automatic['lsb']['codename']
  default['google_stackdriver']['repo_url'] = 'http://repo.stackdriver.com/apt'
  default['google_stackdriver']['config_path'] = '/etc/default/stackdriver-agent'
when 'debian'
  default['google_stackdriver']['repo_dist'] = automatic['lsb']['codename']
  default['google_stackdriver']['repo_url'] = 'http://repo.stackdriver.com/apt'
  default['google_stackdriver']['config_path'] = '/etc/default/stackdriver-agent'
end
