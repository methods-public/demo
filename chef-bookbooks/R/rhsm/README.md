# rhsm cookbook

[![Cookbook](https://img.shields.io/cookbook/v/rhsm.svg?style=flat)][cookbook]
[![Release](https://img.shields.io/github/release/rightscale-cookbooks/rhsm.svg?style=flat)][release]
[![Build Status](https://img.shields.io/travis/rightscale-cookbooks/rhsm.svg?style=flat)][travis]

[cookbook]: https://supermarket.getchef.com/cookbooks/rhsm
[release]: https://github.com/rightscale-cookbooks/rhsm/releases/latest
[travis]: https://travis-ci.org/rightscale-cookbooks/rhsm

Cookbook to handle RedHat Subscription Management.

Github Repository: [https://github.com/rightscale-cookbooks/rhsm](https://github.com/rightscale-cookbooks/rhsm)

# Requirements

* Chef 11 or higher
* Platform
  * RHEL 6
  * RHEL 7

# Usage

To register the instance with the RedHat subscription service, run the `rhsm::register` recipe with the following attributes set:

- `node['rhsm']['username']` - RedHat account username
- `node['rhsm']['password']` - RedHat account password

To unregister the instance, run the `rhsm::unregister` recipe.

To register the instance and to unregister at shutdown, run the `rhsm::default` recipe setting the same attributes required for `rhsm::register`.

# Attributes

- `node['rhsm']['username']` - RedHat account username
- `node['rhsm']['password']` - RedHat account password

# Recipes

## `rhsm::default`

Runs `rhsm::register` and setups a service to unregister the instance at shutdown.

## `rhsm::register`

Registers instance with the RedHat subscription service.

## `rhsm::unregister`

Unregisters instance with the RedHat subscription service.

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
