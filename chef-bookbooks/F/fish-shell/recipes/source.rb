#
# Cookbook Name:: fish-shell
# Recipe:: source
#
# Copyright (c) 2015 ChefFurs
# Licenced under BSD 2-Clause

include_recipe 'build-essential'

source_version = node['fish-shell']['source']['version']

dependencies = value_for_platform(
  %w(redhat centos fedora scientific) => { 'default' => ['ncurses-devel'] },
  'default' => []
)

dependencies.each do |dependency|
  package dependency do
    action :install
  end
end

ark 'fish-shell' do
  url "http://fishshell.com/files/#{source_version}/fish-#{source_version}.tar.gz"
  version source_version
  checksum node['fish-shell']['source']['checksum']
  action [:install_with_make]
end

# TODO: add to etc/shells if it is not already on OS X and rhel
