#
# Cookbook Name:: netcdf
# Recipe:: dependencies
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs dependencies required to build libraries

package "gcc"
package "gcc-c++"
package "make"
package "openssl-devel"