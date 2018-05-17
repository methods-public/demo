#
# Cookbook Name:: netcdf
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
  
include_recipe "netcdf::dependencies"

include_recipe "netcdf::zlib"

include_recipe "netcdf::szip"

include_recipe "netcdf::hdf5"

include_recipe "netcdf::netcdf"
