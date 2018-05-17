#
# Cookbook Name:: fish-shell
# Recipe:: package
#
# Copyright (c) 2015 ChefFurs
# Licenced under BSD 2-Clause

yum_repository 'fish-shell' do
  description 'Fish shell - 2.x release series (RedHat_RHEL-6)'
  baseurl 'http://download.opensuse.org/repositories/shells:/fish:/release:/2/RedHat_RHEL-6/'
  gpgkey 'http://download.opensuse.org/repositories/shells:/fish:/release:/2/RedHat_RHEL-6/repodata/repomd.xml.key'
  action :create
  only_if { platform_family?('rhel') }
end

package 'fish' do
  action :install
end
