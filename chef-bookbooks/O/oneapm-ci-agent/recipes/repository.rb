#
# Cookbook Name:: oneapm-ci-agent
# Recipe:: repository
#


case node['platform_family']
when 'debian'
  include_recipe 'apt'

  package 'apt-transport-https' do
    action :install
  end

  apt_repository 'oneapm-ci-agent' do
    keyserver 'hkp://keyserver.ubuntu.com:80'
    key '54B043BC'
    uri node['oneapm-ci-agent']['aptrepo']
    distribution node['oneapm-ci-agent']['aptrepo_dist']
    components ['main']
    action :add
  end

when 'rhel', 'fedora'
  include_recipe 'yum'

  yum_repository 'oneapm-ci-agent' do
    name 'oneapm-ci-agent'
    description 'oneapm-ci-agent'
    url node['oneapm-ci-agent']['yumrepo']
    gpgcheck false
    enabled true
    action :add
  end
end
