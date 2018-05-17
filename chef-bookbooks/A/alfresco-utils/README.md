# chef-alfresco-utils cookbook
[![Build Status](https://travis-ci.org/Alfresco/chef-alfresco-utils.svg)](https://travis-ci.org/Alfresco/chef-alfresco-utils?branch=master)
[![Cookbook](http://img.shields.io/cookbook/v/alfresco-appserver.svg)](https://github.com/Alfresco/chef-alfresco-utils)
[![Coverage Status](https://coveralls.io/repos/github/Alfresco/chef-alfresco-utils/badge.svg?branch=master)](https://coveralls.io/github/Alfresco/chef-alfresco-utils?branch=master)

This cookbook contains commons libraries and recipes for [Chef-Alfresco](https://github.com/Alfresco/chef-apache_tomcat)

## Requirements

### Cookbooks

The following cookbooks are direct dependencies because they're used for common "default" functionality.

- [`java`](https://github.com/agileorbit-cookbooks/java) This cookbook installs a Java JDK/JRE. It defaults to installing OpenJDK, but it can also install Oracle and IBM JDKs.
- [`yum-epel`](https://github.com/chef-cookbooks/yum-epel) Extra Packages for Enterprise Linux
- [`yum-repoforge`](https://github.com/chef-cookbooks/yum-repoforge) Extra RPM packages

### Platforms

The following platforms are supported and tested with Test Kitchen:

- CentOS 7+

### Chef

- Chef 12.1+

## Attributes

N/A 

## Usage

Just add the reference of this cookbook inside your `metadata.rb` file:

```
depends 'alfresco-utils', '~> v0.1'
```

## Recipes

- `alfresco-utils::java` will install java with attributes defined in attributes/java
- `alfresco-utils::node_json` will create a json file in `/tmp/node.json` with the content of the Chef Node
- `alfresco-utils::package-repositories` will install the extra yum repositories

## Testing
Refer to: [Testing](./TESTING.md)
## License and Authors

- Author:: Marco Mancuso (<marco.mancuso@alfresco.com>)

```text
Copyright 2017, Alfresco

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
```
