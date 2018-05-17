# Encoding: utf-8
#
# Cookbook Name:: elasticsearch
# Recipe:: default
#

include_recipe 'chef-sugar'

%w(
  /.embulk/
  /.embulk/bin
).each do |path|
  directory node['embulk']['home'] + path do
    owner node['embulk']['user']
    group node['embulk']['group']
    recursive true
  end
end

remote_file 'embulk-latest' do
  source 'http://dl.embulk.org/embulk-' + node['embulk']['version'] + '.jar'
  path node['embulk']['home'] + '/.embulk/bin/embulk'
  owner node['embulk']['user']
  group node['embulk']['group']
  mode '0755'
  backup false
end

cookbook_file '/etc/profile.d/embulk.sh' do
  source 'etc/profile.d/embulk.sh'
  owner 'root'
  group 'root'
  mode '0755'
end
