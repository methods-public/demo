#
# Cookbook Name:: netcdf
# Recipe:: zlib
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Install ZLib library

zlib_version = node['netcdf']['zlib']['version']
remote_file "#{Chef::Config[:file_cache_path]}/zlib-#{zlib_version}.tar.gz" do
  source "http://zlib.net/zlib-#{zlib_version}.tar.gz"
  not_if { File.exist?("/usr/local/lib/libz.so") }
  notifies :run, "bash[install zlib]", :immediately
end

bash "install zlib" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf #{Chef::Config[:file_cache_path]}/zlib-#{zlib_version}.tar.gz
    (cd zlib-#{zlib_version} && ./configure && make check install)
  EOH
  action :nothing 
end