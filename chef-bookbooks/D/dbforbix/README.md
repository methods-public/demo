# dbforbix Cookbook

Description

# Requirements

## Cookbooks

The following cookbooks are dependencies for this:

* systemd - needed to install dbforbix services on systemd.

## Java

This daemon needs java to work. I decided to not depend the
java cookbook on this because many people install java using other methods.

## Platform

The following platforms are supported and tested:

* CentOS 7.2

## Chef Server

The recommended chef version is at least >= 12.5

# Usage

To use the cookbook, you can just add the `default` recipe to the run_list. It
will install on /opt/dbforbix and and configure the daemon and init scripts.

# Attributes

Take a look at the attributes if you want to customize install location and
configuration options.

Attributes are documented on `attributes/default.rb` file. This way I don't need
to duplicate definitions here and there :)

# Additional drivers

The recipe `dbforbix::drivers` contains some driver packages to download and
install. But unfortunately, dbforbix 3.x does not support loading external
jars, so the jars must be embedded in the main `dbforbix\_run.jar` file.

If you want additional drivers, create a custom package bundle and use it. For
example, to include the MSSQL JDBC driver, download the archive from the internet
(url is at the `attributes/drivers.rb` file), and repack the `dbforbix_run.jar`, 
including the file `mssql-jdbc-6.2.2.jre8.jar` and modifying the manifest.

# License and Author

- Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
- Author:: Tiago Cruz (<tiago.cruz@movile.com>)

Copyright 2018, Movile

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
