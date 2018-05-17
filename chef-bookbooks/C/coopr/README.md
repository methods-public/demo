# coopr cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/coopr.svg)](https://supermarket.getchef.com/cookbooks/coopr)
[![Apache License 2.0](http://img.shields.io/badge/license-apache%202.0-green.svg)](http://opensource.org/licenses/Apache-2.0)
[![Build Status](http://img.shields.io/travis/caskdata/coopr_cookbook.svg)](http://travis-ci.org/caskdata/coopr_cookbook)
[![Code Climate](https://codeclimate.com/github/caskdata/coopr_cookbook/badges/gpa.svg)](https://codeclimate.com/github/caskdata/coopr_cookbook)

## Requirements

* Oracle Java JDK 6+ (JDK 7 provided by `java` cookbook)

## Optional dependencies

* ZooKeeper (provided by `hadoop` cookbook)
* JDBC-compatible database (MySQL, PostgreSQL, Oracle DB)
* JDBC driver JARs

## Usage

This cookbook is designed to install [Coopr](http://coopr.io) using the built-in ZooKeeper and Derby. A full installation
simply needs the `coopr::fullstack` recipe to be included in your server's run_list.

### Attributes

* `['coopr']['conf_dir']` - The directory used inside `/etc/coopr` and used via the alternatives system. Default `conf.chef`
* `['coopr']['repo']['yum_repo_url']` - Specifies URL for fetching RPM packages via YUM
* `['coopr']['repo']['apt_repo_url']` - Specifies URL for fetching DEB packages via APT
* `['coopr']['repo']['apt_components']` - Repository components to use for APT repositories

### Recipes

* `cli` - Installs the `coopr-cli` package
* `config` - Configures all services
* `default` - Runs `config` and `repo` recipes
* `fullstack` - Installs all packages and services on a single node
* `provisioner` - Installs the `coopr-provisioner` package and service
* `repo` - Sets up package manager repositories for coopr packages
* `server` - Installs the `coopr-server` package and service
* `ui` - Installs the `coopr-ui` package and service

## Author

Author:: Cask Data, Inc. (<ops@cask.co>)

## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this software except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
