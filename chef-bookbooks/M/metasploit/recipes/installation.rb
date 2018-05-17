#
# Cookbook:: metasploit
# Recipe:: installation
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#Just one installation file
remote_file '/tmp/msfinstall' do
  source node['metasploit']['url']
  action :create
  mode '755'
  notifies :run, 'execute[msfinstall]', :immediately
end

execute 'msfinstall' do
  command './msfinstall'
  cwd '/tmp/'
  notifies :delete, 'file[delete_install_file]', :immediately
  action :nothing
end

file 'delete_install_file' do
  path '/tmp/msfinstall'
  action :nothing
end
