#
# Cookbook Name:: linux-basic
# Recipe:: packages
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

%w{zip unzip tree tmux curl wget ntpdate}.each do |x|
  package x do
    action :install
  end
end

# Install a list of packages
case node['platform_family']
when 'debian'
  %w{python-software-properties inotify-tools cron-apt telnet netcat net-tools}.each do |x|
    package x do
      action :install
    end
  end
when 'fedora', 'rhel', 'suse'
  %w{inotify-tools cronie}.each do |x|
    package x do
      action :install
    end
  end
else
  Chef::Application.fatal!("Need to customize for OS of #{node['platform_family']}")
end

%w{git dstat make lsof strace tcpdump}.each do |x|
  package x do
    action :install
  end
end
