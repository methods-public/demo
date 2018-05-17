# Cronic Cookbook README

[![Cookbook Version](https://img.shields.io/cookbook/v/cronic.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/socrata-cookbooks/cronic.svg)][travis]

[cookbook]: https://supermarket.chef.io/cookbooks/cronic
[travis]: https://travis-ci.org/socrata-cookbooks/cronic

A cookbook for managing cron jobs under Cronic, a simple cron script wrapper.

Cronic lets you write cron scripts that actually output content, but doesn't
actually output anything to stdout/stderr unless the exit code is non-zero.
This makes it significantly easier to debug cron scripts when they do go bad.

For more info: http://habilis.net/cronic/

## Requirements

This cookbook requires at least Chef 12. It is tested against the two most
recent major Chef versions (currently 13.x and 12.x) and the two most recent
major releases of Ubuntu (16.04 and 14.04), Debian (9 and 8), RHEL (7 and 6),
and Amazon Linux (2 and 1).

## Usage

Declare instances of the `cronic` resource in recipes the same way you would
the [cron resource](https://docs.chef.io/resource_cron.html).

## Recipes

***default***

This recipe is empty, only included so that an `include_recipe 'cronic'` will
do nothing instead of raising an error.

## Resources

### cronic

A custom resource for managing cron jobs to be run via Cronic. Note that the
cronic resource uses the built-in cron resource under the covers, so writes
jobs to the crontab and not `/etc/cron.d/`.

***Syntax:***

```ruby
cronic 'Restart Nginx monthly' do
  command 'service nginx restart'
  user 'root'
  minute 0
  hour 4
  day 1
  month '*'
  weekday '*'
  action :create
end
```

All actions and properties should be the same as for Chef's built-in 
[cron resource](https://docs.chef.io/resource_cron.html).

***Actions:***

| Action    | Description         |
|-----------|---------------------|
| `:create` | Create the cron job |
| `:delete` | Delete the cron job |

***Properties:***

| Property    | Default       | Description                           |
|-------------|---------------|---------------------------------------|
| command     | Resource name | The command to run via Cronic         |
| minute      | `'*'`         | The minute(s) to run the job          |
| hour        | `'*'`         | The hour(s) to run the job            |
| day         | `'*'`         | The day(s) to run the job             |
| month       | `'*'`         | The month(s) to run the job           |
| weekday     | `'*'`         | The day(s) of the week to run the job |
| time        | `nil`         | A frequency at which to run the job   |
| user        | `'root'`      | The user as whom to run the job       |
| mailto      | `nil`         | MAILTO environment variable           |
| path        | `nil`         | PATH environment variable             |
| shell       | `nil`         | SHELL environment variable            |
| home        | `nil`         | HOME environment variable             |
| environment | `{}`          | Any other nvironment variables        |

## Maintainers

- Jonathan Hartman <jonathan.hartman@socrata.com>
