#
# Cookbook Name:: katello
# Recipe:: default
#
# Copyright (C) 2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe "#{cookbook_name}::repo"
include_recipe 'java'

node.set_unless['katello']['admin_password'] = secure_password

if node['katello']['enable_foreman']
  pkg_name = 'katello-foreman-all'

  if platform?('fedora')
    include_recipe 'selinux::disabled' # That's what they say
  end

else
  pkg_name = 'katello-all'
end

package pkg_name do
  action :install
end

# Using Chef to patch Puppet manifests... LOL.
# (Puppet manifest chowns pg_hba.conf to root:root so that Postgres won't start)
cookbook_file '/usr/share/katello/install/puppet/modules/postgres/manifests/config.pp' do
  source 'config.pp'
  owner 'root'
  group 'root'
  mode '00644'
  action :create
end

execute 'katello-configure' do
  command "/usr/sbin/katello-configure -b --user-pass=#{node['katello']['admin_password']}"
  creates '/etc/katello/katello-configure.conf'
  action :run
end

# Should already be started, but never hurts to make sure
service 'postgresql' do
  action [:enable, :start]
end

# Drives the thin webserver as well as all the other deps like signo
service 'katello' do
  action [:enable, :start]
end
