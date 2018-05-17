Description
===========

Installs and configures Couchbase Sync Gateway

Requirements
============
Chef 11 or higher


Platforms
---------

* Microsoft Windows

Cookbooks
---------

* nssm

Attributes
==========
* node['sync-gateway']['edition'] - The edition of Couchbase Sync Gateway to install; 'community' or 'enterprise'
* node['sync-gateway']['version'] - The version of Couchbase Sync Gateway to install
* node['sync-gateway']['build'] - The build of Couchbase Sync Gateway to install
* node['sync-gateway']['package_file'] - The Couchbase Sync Gateway to download and install
* node['sync-gateway']['package_full_url'] - The url path to download the Couchbase Sync Gateway package from
* node['sync-gateway']['package_full_url'] - The full url path to download the Couchbase Sync Gateway package from
* node['sync-gateway']['install_dir'] - The path to the directory, where Couchbase Sync Gateway will be installed
* node['sync-gateway']['service_name'] - The name of the Couchbase Sync Gateway service

Couchbase Sync Gateway configuration attributes
-----------------------------------------------

* node['sync-gateway']['<propertyName>'] - Couchbase Sync Gateway configuration

See [Sync Gateway Server configuration](http://developer.couchbase.com/documentation/mobile/1.1.0/develop/guides/sync-gateway/configuring-sync-gateway/config-properties/index.html)
for available properties.

Recipes
=======

default
-------

Installs the Couchbase Sync Gateway and starts the service.

