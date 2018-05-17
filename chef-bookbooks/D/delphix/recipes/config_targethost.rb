#
# Cookbook:: delphix
# Recipe:: config_targethost
#
# Copyright:: 2018, The Authors, All Rights Reserved.

group node['delphix']['group'] do
  action :create
end

user node['delphix']['user'] do
  action :create
  group node['delphix']['group']
  comment 'Delphix Automation'
  home "/home/#{node['delphix']['user']}"
  manage_home true
end

directory node['delphix']['toolkit'] do
  action :create
  owner node['delphix']['user']
  group node['delphix']['group']
  mode '0700'
end

directory node['delphix']['mount'] do
  action :create
  owner node['delphix']['user']
  group node['delphix']['group']
  mode '0700'
end

directory "/home/#{node['delphix']['user']}/.ssh" do
  action :create
  owner node['delphix']['user']
  group node['delphix']['group']
  mode '0700'
end

file "/home/#{node['delphix']['user']}/.ssh/authorized_keys" do
  action :create_if_missing
  owner node['delphix']['user']
  group node['delphix']['group']
  mode '0600'
end

if node['delphix']['ssh']['user'] != '' and node['delphix']['ssh']['key']
  ssh_authorize_key node['delphix']['ssh']['user'] do
    key node['delphix']['ssh']['key']
    user node['delphix']['user']
  end
end

bash "configure-delphix-user-for-sudo-tty'" do
  user "root"
  code <<-EOS
  echo 'Defaults:delphix_user !requiretty' >> /etc/sudoers
  EOS
  not_if "grep -q 'Defaults:delphix_user !requiretty' /etc/sudoers"
end

bash "configure-delphix-user-for-sudoers'" do
  user "root"
  code <<-EOS
  echo 'delphix_user ALL=NOPASSWD: /bin/mount, /bin/umount, /bin/ps, /bin/mkdir, /bin/rmdir' >> /etc/sudoers
  EOS
  not_if "grep -q 'delphix_user ALL=NOPASSWD: /bin/mount, /bin/umount, /bin/ps, /bin/mkdir, /bin/rmdir' /etc/sudoers"
end

execute 'validate-etc-sudoers' do
  user 'root'
  command 'visudo -cf /etc/sudoers'
end
