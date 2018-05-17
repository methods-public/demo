# Cookbook Name:: google_stackdriver
# Recipe:: plugins
#
# Copyright 2017, Table XI
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
#

include_recipe('google_stackdriver::default')

%w[apache elasticsearch memcached mongodb nginx redis].each do |plugin|
  file "#{node['google_stackdriver']['plugins']['conf_dir']}#{plugin}.conf" do
    action :delete
    notifies :restart, 'service[stackdriver-agent]', :delayed
    not_if { node['google_stackdriver']['plugins'][plugin]['enable'] }
  end
end

# Apache plugin

template "#{node['google_stackdriver']['plugins']['conf_dir']}apache.conf" do
  source 'apache-conf.erb'
  variables(
    :url => node['google_stackdriver']['plugins']['apache']['mod_status_url'],
    :user => node['google_stackdriver']['plugins']['apache']['user'],
    :password => node['google_stackdriver']['plugins']['apache']['password']
  )
  notifies :restart, 'service[stackdriver-agent]', :delayed
  only_if { node['google_stackdriver']['plugins']['apache']['enable'] }
end

# Elastic Search plugin

package node['google_stackdriver']['plugins']['elasticsearch']['package'] do
  only_if { node['google_stackdriver']['plugins']['elasticsearch']['enable'] }
end

template "#{node['google_stackdriver']['plugins']['conf_dir']}elasticsearch.conf" do
  source node['google_stackdriver']['plugins']['elasticsearch']['template']
  variables(
    :http => node['google_stackdriver']['plugins']['elasticsearch']['http'],
    :url => node['google_stackdriver']['plugins']['elasticsearch']['url'],
    :request_stats => node['google_stackdriver']['plugins']['elasticsearch']['request_stats']
  )
  notifies :restart, 'service[stackdriver-agent]', :delayed
  only_if { node['google_stackdriver']['plugins']['elasticsearch']['enable'] }
end

# MongoDB plugin

template "#{node['google_stackdriver']['plugins']['conf_dir']}mongodb.conf" do
  source 'mongodb.conf.erb'
  variables(
    :host => node['google_stackdriver']['plugins']['mongodb']['host'],
    :port => node['google_stackdriver']['plugins']['mongodb']['port'],
    :username => node['google_stackdriver']['plugins']['mongodb']['username'],
    :password => node['google_stackdriver']['plugins']['mongodb']['password'],
    :secondary_query => node['google_stackdriver']['plugins']['mongodb']['secondary_query']
  )
  notifies :restart, 'service[stackdriver-agent]', :delayed
  only_if { node['google_stackdriver']['plugins']['mongodb']['enable'] }
end

# Nginx plugin

template "#{node['google_stackdriver']['plugins']['conf_dir']}nginx.conf" do
  source 'nginx.conf.erb'
  variables(
    :url => node['google_stackdriver']['plugins']['nginx']['url'],
    :username => node['google_stackdriver']['plugins']['nginx']['username'],
    :password => node['google_stackdriver']['plugins']['nginx']['password']
  )
  notifies :restart, 'service[stackdriver-agent]', :delayed
  only_if { node['google_stackdriver']['plugins']['nginx']['enable'] }
end

# Redis plugin
node['google_stackdriver']['plugins']['redis']['package'].each do |p|
  package p do
    only_if { node['google_stackdriver']['plugins']['redis']['enable'] }
  end
end

execute 'install hiredis for amazon > 2015' do
  command 'pip install hiredis'
  only_if { node['platform'] == 'amazon' }
  only_if { node['platform_version'].to_i > 2015 }
  only_if { node['google_stackdriver']['plugins']['redis']['enable'] }
end

template "#{node['google_stackdriver']['plugins']['conf_dir']}redis.conf" do
  source 'redis.conf.erb'
  variables(
    :redis_node => node['google_stackdriver']['plugins']['redis']['node'],
    :host => node['google_stackdriver']['plugins']['redis']['host'],
    :port => node['google_stackdriver']['plugins']['redis']['port'],
    :timeout => node['google_stackdriver']['plugins']['redis']['timeout']
  )
  notifies :restart, 'service[stackdriver-agent]', :delayed
  only_if { node['google_stackdriver']['plugins']['redis']['enable'] }
end

# Memcache plugin

template "#{node['google_stackdriver']['plugins']['conf_dir']}memcached.conf" do
  source 'memcached.conf.erb'
  variables(
    :host => node['google_stackdriver']['plugins']['memcached']['host'],
    :port => node['google_stackdriver']['plugins']['memcached']['port']
  )
  notifies :restart, 'service[stackdriver-agent]', :delayed
  only_if { node['google_stackdriver']['plugins']['memcached']['enable'] }
end
