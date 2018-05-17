#
# Cookbook Name:: netdevops
# Recipe:: language
#
# Copyright 2015 John Deatherage
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

# -----------------------------------------------------------------------------
# Ruby
# -----------------------------------------------------------------------------

include_recipe 'chruby::default'
# builds rubies
include_recipe 'chruby::system'

template "#{node['netdevops']['user']['home']}/.gemrc" do
  source 'gemrc.erb'
  owner node['netdevops']['user']['name']
  group node['netdevops']['user']['group']
end

ruby_block 'refresh_gemrc' do
  action :nothing
  block do
    Gem.configuration = Gem::ConfigFile.new []
  end
end

node['netdevops']['package']['gem'].each do |gem|
  gem_package gem do
    gem_binary("/opt/rubies/#{node['chruby']['default']}/bin/gem")
    # options(" --install-dir #{node['netdevops']['user']['home']}/.gem/ruby/#{node['chruby']['default']}/gems")
    action :install
  end
end

chef_dk 'my_chef_dk' do
  version node['chef_dk']['version']
  action :install
end

# -----------------------------------------------------------------------------
# Golang
# -----------------------------------------------------------------------------

include_recipe 'golang::default'

# -----------------------------------------------------------------------------
# Python
# -----------------------------------------------------------------------------

# resource will always be updated (rehash)
include_recipe 'pyenv::user'

# install packages with pip via execute - make cleaner with better user-install pip support
node['netdevops']['package']['pip'].each do |package_name|
  execute "#{node['netdevops']['user']['home']}/.pyenv/shims/pip install #{package_name}" do
    cwd node['netdevops']['user']['home']
    user node['netdevops']['user']['name']
    group node['netdevops']['user']['group']
    not_if { ::File.directory?("#{node['netdevops']['user']['home']}/.pyenv/versions/#{node['netdevops']['python']['version']}/lib/python2.7/site-packages/#{package_name}") }
  end
end

# treat openstack packages differently.  again, shouldn't be using execute for this
node['netdevops']['package']['openstackpip'].each do |package_name|
  execute "#{node['netdevops']['user']['home']}/.pyenv/shims/pip install #{package_name}" do
    cwd node['netdevops']['user']['home']
    user node['netdevops']['user']['name']
    group node['netdevops']['user']['group']
    pip_dir = package_name.sub('python-', '')
    not_if { ::File.directory?("#{node['netdevops']['user']['home']}/.pyenv/versions/#{node['netdevops']['python']['version']}/lib/python2.7/site-packages/#{pip_dir}") }
  end
end

# install eznc differently because of namespace
execute "#{node['netdevops']['user']['home']}/.pyenv/shims/pip install junos-eznc" do
  cwd node['netdevops']['user']['home']
  user node['netdevops']['user']['name']
  group node['netdevops']['user']['group']
  not_if { ::File.directory?("#{node['netdevops']['user']['home']}/.pyenv/versions/#{node['netdevops']['python']['version']}/lib/python2.7/site-packages/jnpr/junos") }
end

# install ansible-junos-stdlib
execute "#{node['netdevops']['user']['home']}/.pyenv/shims/ansible-galaxy install --force Juniper.junos" do
  not_if { ::File.directory?('/etc/ansible/roles/Juniper.junos') }
end

# -----------------------------------------------------------------------------
# Misc
# -----------------------------------------------------------------------------
