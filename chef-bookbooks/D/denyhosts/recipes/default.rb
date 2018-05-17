#
# Cookbook Name:: denyhosts
# Recipe:: default
#
# Copyright 2012-2014, North County Tech Center, LLC
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

include_recipe "yum-epel"

package "denyhosts"
package "tcp_wrappers"

workdir = node['denyhosts']['config']['WORK_DIR']

service "denyhosts" do
  action [ :enable, :start ]
end

template "/etc/denyhosts.conf" do
  source "denyhosts.conf.erb"
  owner "root"
  group "root"
  mode  "0600"
  notifies :restart, "service[denyhosts]"
end

template "#{workdir}/allowed-hosts" do
  source "allowed-hosts.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[denyhosts]"
end

