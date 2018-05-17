#
# Cookbook Name:: hipchat_client
# Recipe:: linux
#

CODENAME = node['lsb']['codename']

case node['platform']
when 'debian', 'ubuntu'
  if CODENAME == 'trusty' || CODENAME == 'xenial'
    apt_repository node['hipchat_client']['repo_name'] do
      uri         node['hipchat_client']['uri']
      key         node['hipchat_client']['key']
      components  ['main']
      action :add
    end

    package 'hipchat4' do
      action :install
    end
  end
when 'redhat', 'centos', 'fedora'
  yum_repository node['hipchat_client']['repo_name'] do
    description node['hipchat_client']['description']
    baseurl node['hipchat_client']['baseurl']
    gpgkey node['hipchat_client']['key']
    action :create
  end

  yum_package 'hipchat4' do
    options '--nogpgcheck'
    action :install
  end
end
