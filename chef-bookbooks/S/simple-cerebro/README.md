# Description

Sets up cerebro, that is all.
It doesn't install or depend on apache, nginx, etc... however cerebro needs at least java 1.8 or newer to run, so don't forget it.

# Usage

Override each `node['cerebro']['download_url']`, `node['cerebro']['checksum']`, `node['cerebro']['version']`.

# Custom init service

This cookbook is designed to be wrapped by yours project cookbook.
In this use-case you don't need to include simple-kibana::default recipe.

Do something like this in yours default recipe:

```ruby
include_recipe 'simple-cerebro::install'
include_recipe 'simple-cerebro::configure'
include_recipe 'mywrapper-cerebro::service_upstart' # I want to use upstart
...
```

# Requirements

## Platform:

* debian
* centos

## Cookbooks:

* ark
* runit
 
#Attributes

* `['cerebro']['config']['application.secret']` - This should always be replaced
* `['cerebro']['config']['application.langs']` - Defaults to `en`
* `['cerebro']['config']['host']` - Defaults to `http://localhost:9200`
* `['cerebro']['config']['logger.root']` - Defaults to `ERROR`
* `['cerebro']['config']['logger.play']` - Defaults to `INFO`
* `['cerebro']['config']['logger.application']` - Defaults to `DEBUG`
* `['cerebro']['download_url']` - Defaults to `https://github.com/lmenezes/cerebro/releases/download/v0.3.1/cerebro-0.3.1.tgz`
* `['cerebro']['checksum']` - Defaults to `23e2573abc41087237a69f775ebfb220af4b77745a37f6eea507cee69fd90896`
* `['cerebro']['version']` - Defaults to `0.3.1`
* `['cerebro']['user']` - Defaults to `Cerebro`
* `['cerebro']['group']` - Defaults to `Cerebro`
* `['cerebro']['dir']` - Defaults to `/opt`
* `['cerebro']['path']['logs']` - Defaults to `/var/log/cerebro`


# License and Authors

License:: Apache 2.0
Authors:: David Wilson
Source:: https://github.com/One-Model/simple-cerebro-cookbook
Issues:: https://github.com/One-Model/simple-cerebro-cookbook/issues

Credit:: Much of this recipe was adapted from the simple-kibana recipe https://github.com/jsirex/simple-kibana-cookbook
