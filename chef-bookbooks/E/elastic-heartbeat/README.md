elastic-heartbeat Cookbook
================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-heartbeat.svg)](https://github.com/vkhatri/chef-heartbeat) [![Build Status](https://travis-ci.org/vkhatri/chef-heartbeat.svg?branch=master)](https://travis-ci.org/vkhatri/chef-heartbeat)

This is a [Chef] cookbook to manage [Heartbeat].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/elastic-heartbeat).


## Most Recent Release

```ruby
cookbook 'elastic-heartbeat', '~> 0.1.1'
```

## From Git

```ruby
cookbook 'elastic-heartbeat', github: 'vkhatri/chef-heartbeat',  tag: 'v0.1.1'
```

## Repository

```
https://github.com/vkhatri/chef-heartbeat
```

## Supported OS

This cookbook was tested on CentOS & Ubuntu Linux and expected to work on other RHEL platforms.


## Cookbook Dependency

- elastic_beats_repo
- yum-plugin-versionlock

## Recipes

- `elastic-heartbeat::attributes` - cookbook derived default attributes

- `elastic-heartbeat::config` - configure heartbeat

- `elastic-heartbeat::default` - default recipe (use it for run_list)

- `elastic-heartbeat::install` - install heartbeat package for linux platform


## Core Attributes


* `default['heartbeat']['version']` (default: `5.2.2`): heartbeat version

* `default['heartbeat']['ignore_version']` (default: `false`): ignore heartbeat version for `package` install

* `default['heartbeat']['release']` (default: `1`): heartbeat release for yum package

* `default['heartbeat']['service']['init_style']` (default: `init`): heartbeat service init system, options: init, runit

* `default['heartbeat']['conf_dir']` (default: `/etc/heartbeat`): heartbeat yaml configuration file directory

* `default['heartbeat']['conf_file']` (default: `/etc/heartbeat/heartbeat.yml`): heartbeat configuration file

* `default['heartbeat']['notify_restart']` (default: `true`): whether to restart heartbeat service on configuration file change

* `default['heartbeat']['disable_service']` (default: `false`): whether to stop and disable heartbeat service

* `default['heartbeat']['monitors_dir']` (default: `/etc/heartbeat/conf.d`): monitors configuration file directory

* `default['heartbeat']['setup_repo']` (default: `true`): whether to manage the beats apt/yum repository

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[Heartbeat]: https://www.elastic.co/products/beats/heartbeat
[Contributors]: https://github.com/vkhatri/chef-heartbeat/graphs/contributors
