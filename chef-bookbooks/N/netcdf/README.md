NetCDF Cookbook
=============
NetCDF is a set of software libraries and self-describing, machine-independent data formats that support the creation, access, and sharing of array-oriented scientific data. NetCDF was developed and is maintained at Unidata. Unidata provides data and software tools for use in geoscience education and research. Unidata is part of the University Corporation for Atmospheric Research (UCAR) Community Programs (UCP). Unidata is funded primarily by the National Science Foundation.

This set of recipes compiles the pre-requisite libraries as well as the NetCDF library

More information about NetCDF may be found [at the NetCDF website](http://www.unidata.ucar.edu/software/netcdf/docs/index.html)

Requirements
------------
### Platforms
- CentOS 6.6

Attributes
----------
- `node['netcdf']['zlib']['version']` = The version of ZLib to install. Check [the ZLib website](http://www.zlib.net) for version information  (String)
- `node['netcdf']['szip']['version']` = The version of SZip to install. Check [the SZip section of the HDF website](http://www.hdfgroup.org/doc_resource/SZIP/) for version information. (Note licensing terms at the site)  (String)
- `node['netcdf']['szip']['skip']` = Skip installing SZip. SZip is optional and its terms of use may not meet your needs (Boolean)
- `node['netcdf']['hdf5']['version']` = The version of HDF5 to install. Check [the HDF website](http://www.hdfgroup.org/HDF5/release/obtain5.html) for version information. (String)
- `node['netcdf']['hdf5']['skip_check']` = Skip compile-time testing (Boolean)
- `node['netcdf']['netcdf']['version']` = The version of NetCDF to install. Check [the NetCDF Github Repository](https://github.com/Unidata/netcdf-c/releases) for version information (String)
- `node['netcdf']['netcdf']['skip_check']` = Skip compile-time testing (Boolean)

Usage
-----
Simply include the default recipe (netcdf::default) on an instance that needs NetCDF on it.
 
Authors
-------
- Author:: Ivan Suftin (<isuftin@usgs.gov>)

License
-------
Unless otherwise noted below, this software is in the public domain because it contains
materials that originally came from the United States Geological Survey, an agency of the
United States Department of Interior. For more information, see the official USGS
copyright policy at: http://www.usgs.gov/visual-id/credit_usgs.html#copyright

More information in [license file](https://github.com/USGS-WSI-COOKBOOKS/stig/blob/master/LICENSE)