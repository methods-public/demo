[![Cookbook Version](https://img.shields.io/cookbook/v/alphard-chef-artifactory.svg)](https://supermarket.chef.io/cookbooks/alphard-chef-artifactory)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Build Status](https://travis-ci.org/hydra-technologies/alphard-chef-artifactory.svg?branch=master)](https://travis-ci.org/hydra-technologies/alphard-chef-artifactory)
[![Coverage Status](https://coveralls.io/repos/github/hydra-technologies/alphard-chef-artifactory/badge.svg?branch=master)](https://coveralls.io/github/hydra-technologies/alphard-chef-artifactory?branch=master)

Alphard Artifactory Cookbook
====================

This cookbook provides a resource wrapper for artifactory server.

## Requirements

- Ubuntu 14.04

### Chef

- Chef 12.0 or later

## Packages
- `java` - alphard-chef-artifactory needs java to launch tomcat container
- `apache2` -  alphard-chef-artifactory needs apache2 to install a proxuy pass reverse

## Attributes

The configuration attributes are a partial implementation of the artifactory configuration xml schema :
https://www.jfrog.com/public/xsd/artifactory-v1_7_9.xsd. You can find documentation here and on the artifactory web site.

# Install
- `['java']['install_flavor']` - the java install flavor [default: oracle]
- `['java']['jdk_version']` - the java install flavor [default: 8]
- `['java']['oracle']['accept_oracle_download_terms']` - the java install flavor [default: true]
- `['alphard']['artifactory']['home']` - the artifactory home path
- `['alphard']['artifactory']['version']` - the artifactory version
- `['alphard']['artifactory']['fqdn']` - the artifactory fqdn [default: localhost]
- `['alphard']['artifactory']['port']` - the artifactory port [default: 8080]
- `['alphard']['artifactory']['url']` - the artifactory url

# Apache2
- `['apache']['listen']` - the apache2 listening port [default: 80 and 8080]
- `['alphard']['artifactory']['apache2']['file']` - the apache2 virtual host file
- `['alphard']['artifactory']['apache2']['fqdn']` - the apache2 virtual host fqdn
- `['alphard']['artifactory']['apache2']['port']` - the apache2 virtual host port
- `['alphard']['artifactory']['apache2']['url']` - the apache2 virtual host reverse proxy pass url
- `['alphard']['artifactory']['apache2']['email']` - the apache2 virtual email

# General Config
- `['alphard']['artifactory']['serverName']` - the artifactory server name
- `['alphard']['artifactory']['offlineMode']` - the artifactory offline mode
- `['alphard']['artifactory']['helpLinksEnabled']` - the artifactory help links enabled
- `['alphard']['artifactory']['fileUploadMaxSizeMb']` - the artifactory file upload max size mb
- `['alphard']['artifactory']['dateFormat']` - the artifactory date format

# Security
- `['alphard']['artifactory']['security']['anonAccessEnabled']` - the artifactory security anonymous access enabled
- `['alphard']['artifactory']['security']['anonAccessToBuildInfosDisabled']` - the artifactory security anonymous access to build infos disabled
- `['alphard']['artifactory']['security']['hideUnauthorizedResources']` - the artifactory security hide unauthorized resources
- `['alphard']['artifactory']['security']['passwordSettings']['encryptionPolicy']` - the artifactory security encryption policy support
- `['alphard']['artifactory']['security']['passwordSettings']['expirationPolicy']['enabled']` - the artifactory security encryption policy enabled
- `['alphard']['artifactory']['security']['passwordSettings']['expirationPolicy']['passwordMaxAge']` - the artifactory security encryption policy password max age
- `['alphard']['artifactory']['security']['passwordSettings']['expirationPolicy']['notifyByEmail']` - the artifactory security encryption policy notify by email

- `['alphard']['artifactory']['security']['userLockPolicy']['enabled']` - the artifactory security user lock policy enabled
- `['alphard']['artifactory']['security']['userLockPolicy']['loginAttempts']` - the artifactory security user lock policy login attempts

# Backup
- `['alphard']['artifactory']['backups']` - the artifactory backups (see default attributes for sample configuration)

# Indexer
- `['alphard']['artifactory']['indexer']['cronExp']` - the artifactory indexer cron expression

# Local repositories
- `['alphard']['artifactory']['localRepositories']` - the artifactory local repositories (see default attributes for sample configuration)

# Remote repositories
- `['alphard']['artifactory']['remoteRepositories']` - the artifactory remote repositories (see default attributes for sample configuration)

# Virtual repositories
- `['alphard']['artifactory']['virtualRepositories']` - the artifactory virtual repositories (see default attributes for sample configuration)

# Base URL
- `['alphard']['artifactory']['urlBase']` - the artifactory url base

# Logo
- `['alphard']['artifactory']['logo']` - the artifactory logo

# Footer
- `['alphard']['artifactory']['footer']` - the artifactory footer

# GC Config
- `['alphard']['artifactory']['gcConfig']['cronExp']` - the artifactory gc cron expression

# Cleanup Config
- `['alphard']['artifactory']['cleanupConfig']['cronExp']` - the artifactory cleanup cron expression

# Virtual Cache Cleanup Config
- `['alphard']['artifactory']['virtualCacheCleanupConfig']['cronExp']` - the artifactory virtual cache cleanup cron expression

# Folder Download Config
- `['alphard']['artifactory']['folderDownloadConfig']['enabled']` - the artifactory folder download enabled
- `['alphard']['artifactory']['folderDownloadConfig']['maxDownloadSizeMb']` - the artifactory folder download max download size
- `['alphard']['artifactory']['folderDownloadConfig']['maxFiles']` - the artifactory folder download max files
- `['alphard']['artifactory']['folderDownloadConfig']['maxConcurrentRequests']` - the artifactory folder download max concurrent requests

# System Message Config
- `['alphard']['artifactory']['systemMessageConfig']['enabled']` - the artifactory folder system message enabled
- `['alphard']['artifactory']['systemMessageConfig']['title']` - the artifactory folder system message title
- `['alphard']['artifactory']['systemMessageConfig']['titleColor']` - the artifactory folder system message title color
- `['alphard']['artifactory']['systemMessageConfig']['message']` - the artifactory folder system message
- `['alphard']['artifactory']['systemMessageConfig']['showOnAllPages']` - the artifactory folder system message show on all pages

# Trash Can Config
- `['alphard']['artifactory']['trashcanConfig']['enabled']` - the artifactory trashcan enabled
- `['alphard']['artifactory']['trashcanConfig']['allowPermDeletes']` - the artifactory trashcan allow perm deletes
- `['alphard']['artifactory']['trashcanConfig']['retentionPeriodDays']` - the artifactory trashcan retention period days

Usage
-----
#### alphard-chef-artifactory::default

Just include `alphard-chef-artifactory` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[alphard-chef-artifactory]",
    "recipe[alphard-chef-artifactory::apache2]"
  ]
}
```

## License

Copyright 2009-2016, Hydra Technologies, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Authors
- Frédéric Nowak - frederic.nowak@alphard.io
