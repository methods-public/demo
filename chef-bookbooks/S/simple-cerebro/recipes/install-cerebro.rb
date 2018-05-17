#
# Cookbook Name:: simple-cerebro
# Recipe:: install-cerebro
#

ark 'cerebro' do
  url node['cerebro']['download_url']
  owner node['cerebro']['user']
  group node['cerebro']['group']
  version node['cerebro']['version']
  has_binaries ['bin/cerebro']
  checksum node['cerebro']['checksum']

  prefix_root node['cerebro']['dir']
  prefix_home node['cerebro']['dir']
end
