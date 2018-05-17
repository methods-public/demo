# geminabox-ng: Gem in a Box Cookbook

[![Build Status](https://travis-ci.org/qubitrenegade/chef-geminabox-ng.svg?branch=master)](https://travis-ci.org/qubitrenegade/chef-geminabox-ng) [![Maintainability](https://api.codeclimate.com/v1/badges/2d4143629249e19cca24/maintainability)](https://codeclimate.com/github/qubitrenegade/chef-geminabox-ng/maintainability) [![Dependency Status](https://beta.gemnasium.com/badges/github.com/qubitrenegade/chef-geminabox-ng.svg)](https://beta.gemnasium.com/projects/github.com/qubitrenegade/chef-geminabox-ng) 


Opinionated Cookbook to install and Configure [Gem in a Box](https://github.com/geminabox/geminabox)

Largely inspired by previous versions:

* [Aforward](https://github.com/aforward-obsolete/chef-geminabox)
* [ChrisRoberts](https://github.com/chrisroberts/cookbook-geminabox)
* [Reset](https://github.com/reset/geminabox-cookbook)

And modernized, using [ruby_rbenv](https://github.com/sous-chefs/ruby_rbenv) and [poise-service](https://github.com/poise/poise-service)

## Requirements

### Cookbooks

- [`poise-service`](https://github.com/poise/poise-service) - for cross platform service script creation.
- [`ruby_rbenv`](https://github.com/sous-chefs/ruby_rbenv) - for Ruby binary installation and gem installation.

### Gems

These are installed by the cookbook for the function of the application.

- [`geminabox`](https://github.com/geminabox/geminabox)
- [`unicorn`](https://bogomips.org/unicorn/)

### Platforms

The following platforms have been tested with test kitchen.

- CentOS 6+
- Ubuntu 14.04

### Chef

- 12.7+

## Attributes

This cookbook is designed to provide [Gem in a Box](https://github.com/geminabox/geminabox) out of the box with no or minimal customization.  However, there are a number of optional settings that can be tuned.  Refer to the [Default Attributes](https://github.com/qubitrenegade/chef-geminabox-ng/blob/master/attributes/default.rb) file for a full listing of available tunable attributes.  The most interesting attributes outlined below.

### Geminabox User

- `node['geminabox-ng']['user']['name']` - The username the geminabox process will run as. Defaults to `geminabox`
- `node['geminabox-ng']['name']['home_dir'] - Home Directory of `node['geminabox-ng']['name']` user.  Defaults to `/opt/geminabox`, full path required.

### Geminabox Server Config

The following config options are offered for customization, in most cases the default is the most sane.  Refer to the [Gem in a Box](https://github.com/geminabox/geminabox) page for information on options.

- `node['geminabox-ng-']['config']['build_legacy'] = false`
- `node['geminabox-ng-']['config']['rubygems_proxy'] = true`
- `node['geminabox-ng-']['config']['allow_remote_failure'] = true`

### Ruby Version,

- `node['geminabox-ng-']['ruby_verison']` - version of Ruby to install.  Defaults to 2.4.2

### Unicorn Server

Unicorn runs as middleware between Nginx and the Ruby appliation.

- `node['geminabox-ng-']['unicorn']['worker_processes']` - Number of worker processes.  Default to 4.
- `node['geminabox-ng-']['unicorn']['port']` - port Unicorn should listen on.

### Nginx Server

Uhh.... none right now...  Port is 8000 and it listens for unicorn on 8080... (so even though you can set `node['geminabox-ng-']['unicorn']['port']` it doesn't do anything yet... see the [TODO](https://github.com/qubitrenegade/chef-geminabox-ng#TODO)

### Run List

By default, this cookbook runs all recipes if the default recipe is included.  This is managed via the `node['geminabox-ng']['run_list']` attribute.  Instead of including or excluding recipes from your node run list, you can disable specific recipes by setting them to `false`. e.g. the following will disable user creation/mangement:

```
node['geminabox-ng']['run_list']['user'] = false
```

Please refer to [Recipes](https://github.com/qubitrenegade/chef-geminabox-ng#cookbooks) in the Usage section below for a full list of recipe names.

##Usage

include `recipe[geminabox-ng::default]` in your run list or policy file.

This cookbook is designed to be an out-of-the-box Gem in a Box.  Additional work is required on the Nginx config to enable SSL, sockets, and simple auth... however, it should work for most simple use cases.

### Recipes

This Cookbook performs a number of different tasks which have been isolated into their own recipes.  The intention is that any one of these tasks can be overridden in a parent "wrapper" cookbook, e.g.: you already have a process for creating users so you chose not to use the users cookbook.  In such cases, node attributes (such as `node['geminabox-ng']['user']['name']`) will still need to be set.

The following recipes are provided:

- `user` - Creates user and home directory as determined by `node['geminabox-ng']['user']` attributes.
- `ruby` - Leverages [`ruby_rbenv`](https://github.com/sous-chefs/ruby_rbenv) to install rbenv and ruby
- `server` - The main recipe in the cookbook.  Installs the needed gems [`geminabox`](https://github.com/geminabox/geminabox), [`unicorn`](https://bogomips.org/unicorn/), sets up unicorn config, and creates and starts appropriate init/upstart/systemd script for your system to start geminabox service.
- `proxy` - Installs and configures reverse proxy for Unicorn service.  Requires further work... not currently very configurable.

## Development

- Source hosted at [GitHub][repo]
- Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.

## Testing

This cookbook comes with a full suite of ChefSpec and InSpec tests.  All patches must pass existing tests.  Additional tests required for new features. To run tests use `kitchen test`

## TODO:

- Get travis to work...
- Update Nginx template to be confiurable
- Update Nginx template to handle ssl

## License and Author

- Author:: qubitrenegade ([qbitrenegade@gmail.com](mailto:qbitrenegade@gmail.com))

Copyright 2017, qubitrenegade

```
https://opensource.org/licenses/MIT
```
