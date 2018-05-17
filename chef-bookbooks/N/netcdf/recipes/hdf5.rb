#
# Cookbook Name:: netcdf
# Recipe:: hdf5
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the HDF5 library

hdf5_version = node['netcdf']['hdf5']['version']
make_hdf5_check = node['netcdf']['hdf5']['skip_check'] ? "" : "&& make check"
szip_location = node['netcdf']['szip']['skip'] ? "" : "--with-szlib=/usr/local"

remote_file "#{Chef::Config[:file_cache_path]}/hdf5-#{hdf5_version}.tar.gz" do
  source "http://www.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-#{hdf5_version}/src/hdf5-#{hdf5_version}.tar.gz"
  not_if { File.exist?("/usr/local/lib/libhdf5.so") }
  notifies :run, "bash[install hdf5]", :immediately
end

bash "install hdf5" do
  user "root"
  cwd "/tmp"
  code <<-EOH
   tar -zxf #{Chef::Config[:file_cache_path]}/hdf5-#{hdf5_version}.tar.gz
   (cd hdf5-#{hdf5_version} && export LD_LIBRARY_PATH=/usr/local/lib && ./configure --with-zlib=/usr/local #{szip_location} --prefix=/usr/local && make #{make_hdf5_check} && make install )
  EOH
  action :nothing
end