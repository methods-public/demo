#
# Cookbook Name:: netcdf
# Recipe:: netcdf
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the NetCDF library

netcdf_version = node['netcdf']['netcdf']['version']
make_netcdf_check = node['netcdf']['netcdf']['skip_check'] ? "" : "&& make check"

remote_file "#{Chef::Config[:file_cache_path]}/netcdf-#{netcdf_version}.tar.gz" do
  source "https://codeload.github.com/Unidata/netcdf-c/tar.gz/#{netcdf_version}"
  not_if { File.exist?("/usr/local/lib/libnetcdf.so") }
  notifies :run, "bash[install netcdf]", :immediately
end

bash "install netcdf" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf #{Chef::Config[:file_cache_path]}/netcdf-#{netcdf_version}.tar.gz
    (cd netcdf-c-4.3.3-rc3/ && export CPPFLAGS=-I/usr/local/include && export LDFLAGS=-L/usr/local/lib && ./configure --prefix=/usr/local && make #{make_netcdf_check} && make install)
  EOH
  action :nothing
end