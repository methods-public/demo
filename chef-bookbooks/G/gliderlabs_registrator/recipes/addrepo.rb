#
# Cookbook Name:: gliderlabs_registrator
# Recipe:: addrepo
#
# Copyright (c) 2016 Petr Belyaev <upcfrost@gmail.com>
#

case node['platform']
when 'redhat'
  yum_repository 'ha-framework' do
    description 'ha-framework repo'
    baseurl "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/RHEL_#{node['platform_version'][0]}/"
    gpgkey "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/RHEL_#{node['platform_version'][0]}//repodata/repomd.xml.key"
    action :create
  end
when 'centos'
  yum_repository 'ha-framework' do
    description 'ha-framework repo'
    baseurl "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/CentOS_#{node['platform_version'][0]}/"
    gpgkey "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/CentOS_#{node['platform_version'][0]}//repodata/repomd.xml.key"
    action :create
  end
when 'fedora'
  yum_repository 'ha-framework' do
    description 'ha-framework repo'
    baseurl "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/Fedora_#{node['platform_version'][0..1]}/"
    gpgkey "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/Fedora_#{node['platform_version'][0..1]}//repodata/repomd.xml.key"
    action :create
  end
when 'ubuntu'
  apt_repository 'ha-framework' do
    uri        "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/xUbuntu_#{node['platform_version']}/"
    components %w(all amd64)
  end
when 'debian'
  apt_repository 'ha-framework' do
    uri        "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/Debian_#{node['platform_version'][0]}.0/"
    components %w(all amd64)
  end
when 'suse'
  zypper_repo 'ha-framework' do
    name 'ha-framework'
    uri  "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/openSUSE_#{node['platform_version']}"
    key  "http://download.opensuse.org/repositories/home:/upcFrost:/ha-framework/openSUSE_#{node['platform_version']}//repodata/repomd.xml.key"
  end
end
