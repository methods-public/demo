#
# Cookbook Name:: spacewalk-server
# Recipe:: default
#
# Copyright (C) 2013 Yet Another Clever Name
#               2014 - 2017 Phil Schuler
#
# All rights reserved - Do Not Redistribute
#

# Add required YUM repos
include_recipe 'yum-epel' if platform_family?('rhel')
include_recipe 'yum-fedora' if platform_family?('fedora')

case node['platform_family']
when 'rhel'
  remote_file '/etc/yum.repos.d/group_spacewalkproject-java-packages-epel-7.repo' do
    source 'https://copr.fedorainfracloud.org/coprs/g/spacewalkproject/java-packages/repo/epel-7/group_spacewalkproject-java-packages-epel-7.repo'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end

  if node['platform_version'][0] == '6'
    remote_file '/etc/yum.repos.d/group_spacewalkproject-epel6-addons-epel-6.repo' do
      source 'https://copr.fedorainfracloud.org/coprs/g/spacewalkproject/epel6-addons/repo/epel-6/group_spacewalkproject-epel6-addons-epel-6.repo'
      owner 'root'
      group 'root'
      mode '0644'
      action :create
    end
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/spacewalk-repo.rpm" do
  source node['spacewalk']['server']['repo_url']
  action :create
end

package 'spacewalk-repo' do
  source "#{Chef::Config[:file_cache_path]}/spacewalk-repo.rpm"
  action :install
end

%w(spacewalk-setup-postgresql spacewalk-postgresql).each do |p|
  package p do
    action :install
  end
end

template "#{Chef::Config[:file_cache_path]}/spacewalk-answers.conf" do
  source 'spacewalk-answers.conf.erb'
  mode 0755
  action :create
end

execute 'spacewalk-setup' do
  command "spacewalk-setup --non-interactive --skip-db-diskspace-check --answer-file=#{Chef::Config[:file_cache_path]}/spacewalk-answers.conf"
  action :run
  creates '/var/log/rhn/rhn_installation.log'
  only_if { node['spacewalk_installed'].nil? }
end

ohai_hint 'spacewalk_installed' do
  content Hash[:installed, true]
end

link '/etc/init.d/spacewalk-service' do
  to '/usr/sbin/spacewalk-service'
  action :create
end

# RedHat init script doesn't support chkconfig. Imagine that...
service 'spacewalk-service' do
  supports status: true, reload: true, restart: true
  action :start
end
