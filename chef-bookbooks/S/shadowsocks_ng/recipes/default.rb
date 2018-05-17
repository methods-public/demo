#
# Cookbook Name:: shadowsocks_ng
# Recipe:: default
#
# Copyright 2018, Alexander Merkulov
#

python_package node['shadowsocks_ng']['package'] do
  version node['shadowsocks_ng']['version']
end

template node['shadowsocks_ng']['config'] do
  source 'shadowsocks.json.erb'
  mode '0440'
  owner 'root'
  group 'root'
end

poise_service 'ssserver' do
  command "ssserver -c #{node['shadowsocks_ng']['config']}"
  stop_signal 'SIGQUIT'
end
