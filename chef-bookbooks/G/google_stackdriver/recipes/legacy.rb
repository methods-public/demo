# Cookbook Name:: google_stackdriver
# Recpie:: legacy
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

include_recipe 'google_stackdriver::service'

Chef::Resource::Execute.send(:include, GoogleStackdriver::Helper)

execute 'generate hostid' do
  command "/opt/google_stackdriver/stack-config --api-key #{node['google_stackdriver']['api_key']} --genhostid"
  not_if { File.exist? '/opt/google_stackdriver/hostid' }
  only_if { node['google_stackdriver']['gen_hostid'] }
  only_if { stackdriver_legacy? }
  only_if { node['google_stackdriver']['enable'] }
  notifies :restart, 'service[stackdriver-agent]', :delayed
end

Chef::Resource::Template.send(:include, GoogleStackdriver::Helper)

template '/opt/stackdriver/extractor/etc/extractor.conf.d/tags.conf' do
  source 'tags.conf.erb'
  variables(
    :tags => node['google_stackdriver']['tags']
  )
  only_if { stackdriver_legacy? }
  only_if { node['google_stackdriver']['enable'] }
  not_if { node['google_stackdriver']['tags'].empty? }
  notifies :restart, 'service[stackdriver-agent]', :delayed
end
