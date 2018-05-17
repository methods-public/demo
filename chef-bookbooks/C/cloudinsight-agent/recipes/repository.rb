#
# Cookbook Name:: cloudinsight-agent
# Recipe:: repository
#


case node['platform_family']
when 'debian'
  include_recipe 'apt'

  package 'apt-transport-https' do
    action :install
  end

  apt_repository 'cloudinsight-agent' do
    keyserver 'hkp://keyserver.ubuntu.com:80'
    key '54B043BC'
    uri node['cloudinsight-agent']['aptrepo']
    distribution node['cloudinsight-agent']['aptrepo_dist']
    components ['main']
    action :add
  end

when 'rhel', 'fedora'
  include_recipe 'yum'

  yum_repository 'cloudinsight-agent' do
    name 'cloudinsight-agent'
    description 'cloudinsight-agent'
    url node['cloudinsight-agent']['yumrepo']
    gpgcheck false
    enabled true
    action :add
  end
end
