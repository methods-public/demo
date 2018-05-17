# X2go Server Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/x2go-server.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/socrata-cookbooks/x2go-server.svg)][travis]

[cookbook]: https://supermarket.chef.io/cookbooks/x2go-server
[travis]: https://travis-ci.org/socrata-cookbooks/x2go-server

A Chef cookbook for the X2go remote desktop server.

## Requirements

This cookbook currently supports Ubuntu, Debian and Red Hat-ish Linuxes.

As of v1.0, it requires Chef 12.5+ or Chef 12.x and the
[compat_resource](https://supermarket.chef.io/cookbooks/compat_resource)
cookbook.

## Usage

Add the default recipe to your run_list or use one or more of the included
resources in a recipe of your own.

## Recipes

***default***

Do a simple attribute-based install of the X2go server.

## Attributes

***default***

    default['x2go_server']['app']['source'] = nil

An optional source URL or file path to install the x2go server package from.

## Resources

***x2go_server***

A parent resource for the X2go server components.

Syntax:

    x2go_server 'default' do
        source 'http://example.com/x2go.package'
        action :create
    end

Actions:

| Action    | Description                                      |
|-----------|--------------------------------------------------|
| `:create` | Install X2go server and enable/start the service |
| `:remove` | Stop/disable the X2go service and uninstall it   |

Attributes:

| Attribute | Default    | Description                         |
|-----------|------------|-------------------------------------|
| source    | `nil`      | An optional custom package PATH/URL |
| action    | `:create`  | Action(s) to perform                |

***x2go_server_app***

A resource for installation and removal of the X2go server app package.

Syntax:

    x2go_server_app 'default' do
        source 'http://example.com/x2go.package'
        action :install
    end

Actions:

| Action     | Description                       |
|------------|-----------------------------------|
| `:install` | Install the X2go server package   |
| `:remove`  | Uninstall the X2go server package |

Attributes:

| Attribute | Default    | Description                         |
|-----------|------------|-------------------------------------|
| source    | `nil`      | An optional custom package PATH/URL |
| action    | `:install` | Action(s) to perform                |

***x2go_server_service***

A resource for the X2go server service.

Syntax:

    x2go_server_service 'default' do
        action :restart
    end

Actions:

| Action     | Description         |
|------------|---------------------|
| `:enable`  | Enable the service  |
| `:disable` | Disable the service |
| `:start`   | Start the service   |
| `:stop`    | Stop the service    |
| `:restart` | Restart the service |

Attributes:

| Attribute | Default             | Description          |
|-----------|---------------------|----------------------|
| action    | `[:enable, :start]` | Action(s) to perform |

## Maintainers

- Jonathan Hartman <jonathan.hartman@socrata.com>
