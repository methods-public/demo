#
# Cookbook Name:: netcdf
# Recipe:: szip
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the optional szip library for HDF5. Check the license terms at the SZip website before installing. Set netcdf.szip.skip attribute to true to bypass installing this.

szip_version = node['netcdf']['szip']['version']
szip_skip = node['netcdf']['szip']['skip']

remote_file "#{Chef::Config[:file_cache_path]}/szip-#{szip_version}.tar.gz" do
  source "http://www.hdfgroup.org/ftp/lib-external/szip/#{szip_version}/src/szip-#{szip_version}.tar.gz"
  not_if { File.exist?("/usr/local/lib/libsz.so") || szip_skip }
  notifies :run, "bash[install szip]", :immediately
end

bash "install szip" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf #{Chef::Config[:file_cache_path]}/szip-#{szip_version}.tar.gz
    (cd szip-#{szip_version} && ./configure --prefix=/usr/local && make && make install)
  EOH
  action :nothing
end