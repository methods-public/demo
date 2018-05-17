# Cookbook Name:: google_stackdriver
# Recipe:: default
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
raise 'No package repository available for your platform.' unless node['google_stackdriver']['repo_url']

include_recipe 'google_stackdriver::service'

case node['platform_family']
when 'rhel', 'fedora', 'suse', 'amazon'
  yum_repository 'stackdriver' do
    description 'google_stackdriver repo'
    baseurl node['google_stackdriver']['repo_url']
    gpgkey node['google_stackdriver']['gpg_key']
    action :create
    only_if { node['google_stackdriver']['enable'] }
  end

  package 'stackdriver-agent' do
    action node['google_stackdriver']['action']
    only_if { node['google_stackdriver']['enable'] }
  end

when 'debian'
  apt_repository 'stackdriver' do
    uri node['google_stackdriver']['repo_url']
    distribution node['google_stackdriver']['repo_dist']
    components ['main']
    key node['google_stackdriver']['gpg_key']
    only_if { node['google_stackdriver']['enable'] }
  end

  package 'stackdriver-agent' do
    action node['google_stackdriver']['action']
    options '--force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"'
    only_if { node['google_stackdriver']['enable'] }
  end
end

Chef::Resource::Template.send(:include, GoogleStackdriver::Helper)

template node['google_stackdriver']['config_path'] do
  source 'google_stackdriver_agent.erb'
  variables(
    :api_key => node['google_stackdriver']['api_key'],
    :collectd => node['google_stackdriver']['config_collectd'],
    :gcm => stackdriver_legacy? && google_stackdriver? ? false : google_stackdriver?
  )
  notifies :restart, 'service[stackdriver-agent]', :delayed
  only_if { node['google_stackdriver']['enable'] }
  only_if { stackdriver_legacy? || google_stackdriver? }
end

include_recipe 'google_stackdriver::legacy'

include_recipe 'google_stackdriver::gcm'
