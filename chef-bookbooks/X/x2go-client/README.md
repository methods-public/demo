X2go Client Cookbook
====================
[![Cookbook Version](https://img.shields.io/cookbook/v/x2go-client.svg)][cookbook]
[![OS X Build Status](https://img.shields.io/travis/socrata-cookbooks/x2go-client.svg)][travis]
[![Windows Build Status](https://img.shields.io/appveyor/ci/socrata-cookbooks/x2go-client.svg)][appveyor]
[![Linux Build Status](https://img.shields.io/circleci/project/socrata-cookbooks/x2go-client.svg)][circle]
[![Code Climate](https://img.shields.io/codeclimate/github/socrata-cookbooks/x2go-client.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/socrata-cookbooks/x2go-client.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/x2go-client
[travis]: https://travis-ci.org/socrata-cookbooks/x2go-client
[appveyor]: https://ci.appveyor.com/project/socrata-cookbooks/x2go-client
[circle]: https://circleci.com/gh/socrata-cookbooks/x2go-client
[codeclimate]: https://codeclimate.com/github/socrata-cookbooks/x2go-client
[coveralls]: https://coveralls.io/r/socrata-cookbooks/x2go-client

A Chef cookbook for the X2go remote desktop client.

Requirements
============

This cookbook requires Chef 12.6+.

It currently supports Mac OS X, Windows, Ubuntu, and Red Hat/CentoS/Scientific/
etc.

Usage
=====

Add the default recipe to your run_list or use one or more of the included
resources in a recipe of your own.

Recipes
=======

***default***

Do a simple attribute-based install of the X2go client.

Attributes
==========

***default***

    default['x2go_client']['app']['source'] = nil

An optioanl source URL or file path to install the X2go client package from.

Resources
=========

***x2go_client***

A parent resource for the X2go client components.

Syntax:

    x2go_client 'default' do
      source 'http://example.com/x2go.package
      action :create
    end

Actions:

| Action    | Description               |
|-----------|---------------------------|
| `:create` | Install the X2go client   |
| `:remove` | Uninstall the X2go client |

Attributes:

| Attribute | Default   | Description                         |
|-----------|-----------|-------------------------------------|
| source    | `nil`     | An optional custom package path/URL |
| action    | `:create` | Action(s) to perform                |

***x2go_client_app***

A resource for installation and removal of X2go client app packages.

Syntax:

    x2go_client_app 'default' do
      source 'http://example.com/x2go.package'
      action :install
    end

Actions:

| Action     | Description                       |
|------------|-----------------------------------|
| `:install` | Install the X2go client package   |
| `:remove`  | Uninstall the X2go client package |

Attributes:

| Attribute | Default    | Description                         |
|-----------|------------|-------------------------------------|
| source    | `nil`      | An optional custom package path/URL |
| action    | `:install` | Action(s) to perform                |

Providers
=========

***Chef::Provider::X2goClient***

Platform-agnostic provider that wraps each of the X2go client component
resources.

***Chef::Provider::X2goClientApp***

The parent for all platform-specific X2go client app package providers.

***Chef::Provider::X2goClientApp::Rhel***

App package provider for RHEL and RHEL-alike platforms.

***Chef::Provider::X2goClientApp::MacOsX***

App package provider for OS X platforms.

***Chef::Provider::X2goClientApp::Ubuntu***

App package provider for Ubuntu platforms.


***Chef::Provider::X2goClientApp::Windows***

App package provider for Windows platforms.

Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================
- Author: Jonathan Hartman <jonathan.hartman@socrata.com>

Copyright 2015-2016, Socrata, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
