#
# Cookbook Name:: linux-basic
# Recipe:: repo
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'debian'
  include_recipe 'apt'
when 'fedora', 'rhel', 'suse'
  %w{nagios nagios-plugins-all}.each do |x|
    include_recipe 'yum-epel'
  end
end

# case node['platform_family']
# when 'debian'
#   # cookbook_file '/etc/apt/sources.list.d/fluig.list' do
#   #   source 'repo_files/ubuntu_fluig.list'
#   #   mode 0644
#   #   notifies :run, 'execute[should_update_repo]', :immediately
#   # end

#   # cookbook_file '/etc/apt/sources.list.d/maven.list' do
#   #   source 'repo_files/ubuntu_maven.list'
#   #   mode 0644
#   #   notifies :run, 'execute[should_update_repo]', :immediately
#   #   notifies :run, 'execute[apt-key maven]', :immediately
#   # end

#   execute 'apt-key maven' do
#     command 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B70731143DD9F856'
#     action :nothing
#   end

#   # cookbook_file '/etc/apt/sources.list.d/couchbase.list' do
#   #   source 'repo_files/ubuntu_couchbase.list'
#   #   cookbook 'linux-files'
#   #   mode 0644
#   #   notifies :run, 'execute[should_update_repo]', :immediately
#   #   notifies :run, 'execute[apt-key couchbase]', :immediately
#   # end

#   cookbook_file '/etc/apt/sources.list.d/jenkins.list' do
#     source 'repo_files/ubuntu_jenkins.list'
#     mode 0644
#     notifies :run, 'execute[should_update_repo]', :immediately
#     notifies :run, 'execute[apt-key jenkins]', :immediately
#   end

#   execute 'apt-key jenkins' do
#     command 'wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -'
#     action :nothing
#   end

#   execute 'apt-key couchbase' do
#     command 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A3FAA648D9223EDA'
#     action :nothing
#   end

#   execute 'should_update_repo' do
#     command 'touch /tmp/should_update_repo'
#     action :nothing
#   end

#   # Update system
#   execute 'apt-get update' do
#     command 'rm -rf /tmp/should_update_repo && apt-get update'
#     action :run
#     only_if 'test -f /tmp/should_update_repo'
#   end

# when 'fedora', 'rhel', 'suse'
#   epel_repo_fullpath = node['basic']['download_dir'] + '/' + 'epel-release-6-8.noarch.rpm'
#   remote_file 'Download epel repo' do
#     path "#{epel_repo_fullpath}"
#     source "#{node['basic']['epel_release_url']}"
#     use_last_modified true
#     action :create_if_missing
#     notifies :install, 'rpm_package[epel-repo]', :immediately
#   end

#   rpm_package 'epel-repo' do
#     source "#{epel_repo_fullpath}"
#     action :nothing
#     not_if 'rpm -q epel-release'
#   end

#   cookbook_file '/etc/yum.repos.d/jenkins.repo' do
#     source 'repo_files/jenkins.repo'
#     mode 0700
#     notifies :run, 'execute[import jenkins repo key]', :immediately
#   end

#   execute 'import jenkins repo key' do
#     command 'rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
#     action :nothing
#   end

# else
#   Chef::Application.fatal!('Need to customize for OS of #{node[:platform_family]}')
# end
