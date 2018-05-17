# Mongo Chef Gem Installer Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/mongo_chef_gem.svg)](https://supermarket.chef.io/cookbooks/mongo_chef_gem)
[![Build Status](https://secure.travis-ci.org/scopenco/chef-mongo_chef_gem.png?branch=master)](http://travis-ci.org/scopenco/chef-mongo_chef_gem)

## Description

mongo_chef_gem is a library cookbook that provides an LWRP for use
in recipes. It provides a wrapper around `chef_gem` called
`mongo_chef_gem` that eases the installation process, collecting the
prerequisites and side-stepping the compilation phase arms race.

## Scope

This cookbook is concerned with the installation of the `mongo`
Rubygem into Chef's gem path. Installation into other Ruby
environments, or installation of related gems such as `mongo` are
outside the scope of this cookbook.

## Requirements

* Chef 12 or higher

## Usage

```ruby
depends 'mongo_chef_gem', '~> 0.1.0'
```

Then, in a recipe:

```ruby
mongo_chef_gem 'default' do
  action :install
end
```

## Resources Overview

### mongo_chef_gem

The `mongo_chef_gem` resource the build dependencies and installation
of the `mongo` rubygem into Chef's Ruby environment

#### Example
```ruby
mongo_chef_gem 'default' do
  mongo_version '2.1.2'
  bson_ext_version '1.12.4'
  action :install
end
```
#### Parameters
- `mongo_version` - The version of the `mongo` Rubygem to install into
  the Chef environment. Defaults to last version.
- `bson_ext_version` - The version of the `bson_ext` Rubygem to install into
  the Chef environment. Defaults to last version.

#### Actions
- `:install` - Build and install the gem into the Chef environment
- `:remove` - Delete the gem from the Chef environment

## Authors

- Author:: Andrey Skopenko (<andrey@skopenko.net>)

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
