#
# Cookbook Name:: rustlang
# Recipe:: default
#
# Copyright (c) 2015 Matthew Valentine-House
#

# Rust-lang version specific variables
#
architecture = node['kernel']['machine']
version      = node['rustlang']['version']

rust_canonical_basename = "rust-#{version}-#{architecture}-unknown-linux-gnu"

# File blobs used for installation
#
download_file          = "https://static.rust-lang.org/dist/#{rust_canonical_basename}.tar.gz"
cached_download_object = "#{Chef::Config[:file_cache_path]}/rust.tar.gz"

# MAIN RECIPE
#
remote_file cached_download_object do
  source download_file
  use_last_modified false
end

execute "unpack download" do
  command "tar zxvf #{cached_download_object}"
  cwd node['rustlang']['installation_prefix']
end

rust_installation_path = "#{node['rustlang']['installation_prefix']}/#{rust_canonical_basename}"

execute "chef installer" do
  command "sh install.sh"
  cwd rust_installation_path
end

file '/etc/ld.so.conf.d/usr_local.conf' do
  content '/usr/local/lib'
end

execute 'ldconfig'
