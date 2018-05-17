chronograf Cookbook
================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-chronograf.svg)](https://github.com/vkhatri/chef-chronograf) [![Build Status](https://travis-ci.org/vkhatri/chef-chronograf.svg?branch=master)](https://travis-ci.org/vkhatri/chef-chronograf)


This is a [Chef] cookbook to manage [InfluxDB] [Chronograf].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/chronograf).


## Most Recent Release

```ruby
cookbook 'chronograf', '~> 0.1.2'
```

## From Git

```ruby
cookbook 'chronograf', github: 'vkhatri/chef-chronograf',  tag: "v0.1.2"
```

## Repository

```
https://github.com/vkhatri/chef-chronograf
```

## Supported OS

This cookbook was tested on Amazon & Ubuntu Linux and expected to work on other RHEL platforms.



## Cookbook Dependency

None


## Recipes

- `chronograf::default` - default recipe (use it for run_list)

- `chronograf::install` - install chronograf

- `chronograf::config` - configure chronograf


## Core Attributes


* `default['chronograf']['version']` (default: `1.3.7.0`): chronograf version, default install latest

* `default['chronograf']['toml_gem_version']` (default: `~> 0.1.2`): toml gem version

* `default['chronograf']['conf_dir']` (default: `/opt/chronograf`): chronograf toml configuration file directory

* `default['chronograf']['conf_file']` (default: `/opt/chronograf/config.toml`): chronograf configuration file

* `default['chronograf']['notify_restart']` (default: `true`): whether to restart chronograf service on configuration file change

* `default['chronograf']['disable_service']` (default: `false`): whether to stop and disable chronograf service

* `default['chronograf']['bind_host']` (default: `node['ipaddress']`): chronograf bind host

* `default['chronograf']['bind_port']` (default: `10000`): chronograf bind port

* `default['chronograf']['local_database_dir']` (default: `10000`): chronograf bind port



## Configuration File config.toml Attributes

* `default['chronograf']['config']['QueryResponseBytesLimit']` (default: `2_500_000`): chronograf config parameter

* `default['chronograf']['config']['Bind']` (default: `calculated`): chronograf config parameter, derived from `#{node['chronograf']['bind_host']}:#{node['chronograf']['bind_port']}`

* `default['chronograf']['config']['LocalDatabase']` (default: `calculated`): chronograf config parameter, derived from `#{node['chronograf']['local_database_dir']}/chronograf.db`


## chronograf YUM/APT Repository Attributes

* `default['chronograf']['yum']['description']` (default: ``): chronograf yum reporitory attribute

* `default['chronograf']['yum']['gpgcheck']` (default: `true`): chronograf yum reporitory attribute

* `default['chronograf']['yum']['enabled']` (default: `true`): chronograf yum reporitory attribute

* `default['chronograf']['yum']['baseurl']` (default: `calculated`): chronograf yum reporitory attribute

* `default['chronograf']['yum']['gpgkey']` (default: `https://repos.influxdata.com/influxdb.key`): chronograf yum reporitory attribute

* `default['chronograf']['yum']['action']` (default: `:create`): chronograf yum reporitory attribute


* `default['chronograf']['apt']['description']` (default: ``): chronograf apt reporitory attribute

* `default['chronograf']['apt']['components']` (default: `['stable']`): chronograf apt reporitory attribute

* `default['chronograf']['apt']['uri']` (default: `https//repos.influxdata.com/debian`): chronograf apt reporitory attribute

* `default['chronograf']['apt']['key']` (default: `https//repos.influxdata.com/influxdb.key`): chronograf apt reporitory attribute

* `default['chronograf']['apt']['action']` (default: `:add`): chronograf apt reporitory attribute


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
[Chronograf]: https://docs.influxdata.com/chronograf
[InfluxDB]: https://influxdata.com/
[Contributors]: https://github.com/vkhatri/chef-chronograf/graphs/contributors
