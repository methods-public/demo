#
# Cookbook Name:: gnugpg
# Recipe:: _win_install
#
# Copyright (c) 2017 Rodel M. Talampas, All Rights Reserved.

directory node['gnugpg']['win']['install_loc'].to_s do
  group 'Administrators'
  action :create
end

cache_file_path = "#{node['gnugpg']['temp']['directory']}\\gpg_installer_#{node['gnugpg']['win']['version']}.exe"
init_file_path = "#{node['gnugpg']['temp']['directory']}\\config.ini"

# Create an ini file
template init_file_path do
  source 'gpg-config.ini.erb'
end

# Download the installer file
remote_file cache_file_path do
  checksum node['gnugpg']['win']['checksum']
  source node['gnugpg']['win']['download_url']
  backup false
  action :create
  notifies :install, 'windows_package[GNUGPG]', :immediately
end

# Install GNUGPG Windows, in UNAttended mode in Specified Install Directory
windows_package 'GNUGPG' do
  source cache_file_path
  checksum node['gnugpg']['win']['checksum']
  action :nothing
  options " /S /C=#{init_file_path} /D=#{node['gnugpg']['win']['install_loc']}"
  installer_type :custom
end

gnugpg_bin = node['gnugpg']['win']['install_loc'].gsub('\\\\', '/')
gnupg_bin = node['gnugpg']['win']['install_loc_2'].gsub('\\\\', '/')

env 'add_gnugpg_to_path' do
  action :modify
  key_name 'PATH'
  value "#{gnugpg_bin}/bin;#{gnupg_bin}/bin;#{ENV['PATH']}"
  not_if { ENV['PATH'].to_s.include? "#{gnugpg_bin}/bin" }
end

node['gnugpg']['keys']['file'].each do |key|
  batch "import_keys_#{key}" do
    command "gpg --import #{node['gnugpg']['temp']['directory']}\\#{key}"
    retries 3
    only_if { ::File.exist?("#{node['gnugpg']['temp']['directory']}\\#{key}") }
  end
end
