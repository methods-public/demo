# Cookbook Name:: google_stackdriver
# Recpie:: gcm
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

Chef::Resource.send(:include, GoogleStackdriver::Helper)

directory '/etc/google/auth' do
  recursive true
  only_if { google_credentials_from_vars? }
  not_if { google_credentials_from_file? }
  only_if { node['google_stackdriver']['enable'] }
end

template '/etc/google/auth/application_default_credentials.json' do
  source 'application_default_credentials.json.erb'
  mode 0o400
  variables(
    :client_email => node['google_stackdriver']['service_account']['client_email'],
    :client_id => node['google_stackdriver']['service_account']['client_id'],
    :client_x509_cert_url => node['google_stackdriver']['service_account']['client_x509_cert_url'],
    :private_key => node['google_stackdriver']['service_account']['private_key'],
    :private_key_id => node['google_stackdriver']['service_account']['private_key_id'],
    :project_id => node['google_stackdriver']['service_account']['project_id'],
    :x509_cert_url => node['google_stackdriver']['service_account']['x509_cert_url']
  )
  only_if { google_credentials_from_vars? }
  only_if { node['google_stackdriver']['enable'] }
  not_if { google_credentials_from_file? }
end

# https://support.stackdriver.com/customer/en/portal/articles/2621788-running-the-google-stackdriver-and-legacy-stackdriver-agents-together-linux-

service 'gcm-stackdriver-agent' do
  supports :start => true, :stop => true, :status => true, :restart => true, :reload => true
  action(node['google_stackdriver']['enable'] ? :nothing : %i[disable stop])
  only_if { google_stackdriver? && stackdriver_legacy? }
end

service 'gcm-stackdriver-agent-shutdown' do
  service_name 'gcm-stackdriver-agent'
  action %i[disable stop]
  not_if { google_stackdriver? && stackdriver_legacy? }
  only_if 'test -e /etc/init.d/gcm-stackdriver-agent'
end

template node['google_stackdriver']['config_path'].gsub(/stackdriver/, 'gcm-stackdriver') do
  source 'google_stackdriver_agent.erb'
  variables(
    :api_key => false,
    :collectd => true,
    :gcm => true
  )
  action(google_stackdriver? && stackdriver_legacy? && node['google_stackdriver']['enable'] ? :create : :delete)
  notifies :restart, 'service[gcm-stackdriver-agent]', :delayed
end

file '/etc/init.d/gcm-stackdriver-agent' do
  content(lazy { convert_to_gcm(::File.open('/etc/init.d/stackdriver-agent').read) })
  mode 0o755
  action(google_stackdriver? && stackdriver_legacy? && node['google_stackdriver']['enable'] ? :create : :delete)
  notifies :restart, 'service[gcm-stackdriver-agent]', :delayed
end

file '/opt/stackdriver/gcm-stack-config' do
  content(lazy { convert_to_gcm(::File.open('/opt/stackdriver/stack-config').read) })
  mode 0o755
  action(google_stackdriver? && stackdriver_legacy? && node['google_stackdriver']['enable'] ? :create : :delete)
  notifies :restart, 'service[gcm-stackdriver-agent]', :delayed
end

link '/opt/stackdriver/collectd/sbin/gcm-stackdriver-collectd' do
  to '/opt/stackdriver/collectd/sbin/stackdriver-collectd'
  action(google_stackdriver? && stackdriver_legacy? && node['google_stackdriver']['enable'] ? :create : :delete)
  notifies :restart, 'service[gcm-stackdriver-agent]', :delayed
end
