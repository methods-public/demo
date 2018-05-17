# Cookbook Name:: google_stackdriver
# Attributes:: plugins
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

default['google_stackdriver']['plugins']['conf_dir'] = '/opt/stackdriver/collectd/etc/collectd.d/'

default['google_stackdriver']['plugins']['apache']['enable'] = false
default['google_stackdriver']['plugins']['apache']['mod_status_url'] = 'http://127.0.0.1/server-status?auto'
default['google_stackdriver']['plugins']['apache']['user'] = nil
default['google_stackdriver']['plugins']['apache']['password'] = nil

default['google_stackdriver']['plugins']['elasticsearch']['enable'] = false
default['google_stackdriver']['plugins']['elasticsearch']['version'] = '1.0'
default['google_stackdriver']['plugins']['elasticsearch']['http'] = 'http://'
default['google_stackdriver']['plugins']['elasticsearch']['url'] = 'localhost:9200'
if node['google_stackdriver']['plugins']['elasticsearch']['version'].to_f >= 1
  default['google_stackdriver']['plugins']['elasticsearch']['request_stats'] = '/_nodes/_local/stats/'
  default['google_stackdriver']['plugins']['elasticsearch']['template'] = 'elasticsearch-1.conf.erb'
else
  default['google_stackdriver']['plugins']['elasticsearch']['request_stats'] = '/_cluster/nodes/_local/stats?all=true'
  default['google_stackdriver']['plugins']['elasticsearch']['template'] = 'elasticsearch.conf.erb'
end
default['google_stackdriver']['plugins']['elasticsearch']['package'] =
  case node['platform_family']
  when 'debian'
    case node['platform']
    when 'ubuntu'
      'libyajl1' if node['platform_version'].to_i < 14
    when 'debian'
      'libyajl1' if node['platform_version'].to_i < 7
    end
    'libyajl2'
  when 'rhel', 'fedora', 'suse', 'amazon'
    'yajl'
  end

default['google_stackdriver']['plugins']['nginx']['enable'] = false
default['google_stackdriver']['plugins']['nginx']['url'] = 'http://localhost/nginx_status'
default['google_stackdriver']['plugins']['nginx']['username'] = false
default['google_stackdriver']['plugins']['nginx']['password'] = false

default['google_stackdriver']['plugins']['redis']['enable'] = false
default['google_stackdriver']['plugins']['redis']['node'] = 'mynode'
default['google_stackdriver']['plugins']['redis']['host'] = 'localhost'
default['google_stackdriver']['plugins']['redis']['port'] = '6379'
default['google_stackdriver']['plugins']['redis']['timeout'] = 2000
default['google_stackdriver']['plugins']['redis']['package'] =
  case node['platform_family']
  when 'debian'
    if node['platform'] == 'ubuntu' && node['platform_version'].to_i > 15
      ['libhiredis0.13']
    else
      ['libhiredis0.10']
    end
  when 'rhel', 'fedora', 'suse', 'amazon'
    if node['platform'] == 'amazon' && node['platform_version'].to_i > 2015
      ['python-devel', 'gcc']
    else
      ['hiredis']
    end
  end

default['google_stackdriver']['plugins']['mongodb']['enable'] = false
default['google_stackdriver']['plugins']['mongodb']['host'] = 'localhost'
default['google_stackdriver']['plugins']['mongodb']['port'] = '27017'
default['google_stackdriver']['plugins']['mongodb']['username'] = false
default['google_stackdriver']['plugins']['mongodb']['password'] = false
default['google_stackdriver']['plugins']['mongodb']['secondary_query'] = false

default['google_stackdriver']['plugins']['memcached']['enable'] = false
default['google_stackdriver']['plugins']['memcached']['host'] = 'localhost'
default['google_stackdriver']['plugins']['memcached']['port'] = '11211'
