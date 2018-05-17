auditbeat Cookbook
================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-auditbeat.svg)](https://github.com/vkhatri/chef-auditbeat) [![Build Status](https://travis-ci.org/vkhatri/chef-auditbeat.svg?branch=master)](https://travis-ci.org/vkhatri/chef-auditbeat)

This is a [Chef] cookbook to manage [auditbeat].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/auditbeat).


## Most Recent Release

```ruby
cookbook 'auditbeat', '~> 0.0.2'
```


## From Git

```ruby
cookbook 'auditbeat', github: 'vkhatri/chef-auditbeat',  tag: 'v0.0.2'
```


## Repository

```
https://github.com/vkhatri/chef-auditbeat
```


## Supported OS

- CentOS 6, 7
- Ubuntu 14
- Amazon Linux


## Supported Chef

- Chef 12 (last tested on 12.21.3)

- Chef 13 (last tested on 13.2.20)

## Major Changes


## Cookbook Dependency

- windows
- apt
- yum
- yum-plugin-versionlock


## Recipes

- `auditbeat::attributes` - cookbook derived default attributes

- `auditbeat::config` - configure auditbeat

- `auditbeat::default` - default recipe (use it for run_list)

- `auditbeat::install_package` - install auditbeat package for linux platform

- `auditbeat::install_package_preview` - install auditbeat preview (alpha/beta) package for linux platform

- `auditbeat::install_windows` - install auditbeat for windows platform


## Core Attributes


* `default['auditbeat']['version']` (default: `6.0.0-beta1`): auditbeat version

* `default['auditbeat']['ignore_version']` (default: `false`): ignore auditbeat version for `package` install

* `default['auditbeat']['setup_repo']` (default: `true`): setup `apt` or `yum` repository if set to `true`

* `default['auditbeat']['release']` (default: `1`): auditbeat release for yum package

* `default['auditbeat']['package_url']` (default: `auto`): package url for windows installation

* `default['auditbeat']['conf_dir']` (default: `/etc/auditbeat`): auditbeat yaml configuration file directory

* `default['auditbeat']['conf_file']` (default: `/etc/auditbeat/auditbeat.yml`): auditbeat configuration file

* `default['auditbeat']['notify_restart']` (default: `true`): whether to restart auditbeat service on configuration file change

* `default['auditbeat']['disable_service']` (default: `false`): whether to stop and disable auditbeat service


## Configuration File auditbeat.yml Attributes

* `default['auditbeat']['config']['auditbeat.modules']` (default: `[]`): auditbeat modules

* `default['auditbeat']['config']['auditbeat']['registry_file']` (default: `/var/lib/auditbeat/registry`): auditbeat registry location

* `default['auditbeat']['config']['output']` (default: `{}`): configure elasticsearch. logstash, file etc.  output

For more attribute info, visit below links:

https://github.com/elastic/beats/blob/master/auditbeat/auditbeat.reference.yml
https://www.elastic.co/guide/en/beats/auditbeat/current/auditbeat-overview.html


## auditbeat YUM/APT Repository Attributes

* `default['auditbeat']['yum']['description']` (default: ``): beats yum reporitory attribute

* `default['auditbeat']['yum']['gpgcheck']` (default: `true`): beats yum reporitory attribute

* `default['auditbeat']['yum']['enabled']` (default: `true`): beats yum reporitory attribute

* `default['auditbeat']['yum']['baseurl']` (default: `https://packages.elastic.co/beats/yum/el/$basearch`): beats yum reporitory attribute

* `default['auditbeat']['yum']['gpgkey']` (default: `https://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats yum reporitory attribute

* `default['auditbeat']['yum']['metadata_expire']` (default: `3h`): beats yum reporitory attribute

* `default['auditbeat']['yum']['action']` (default: `:create`): beats yum reporitory attribute


* `default['auditbeat']['apt']['description']` (default: `calculated`): beats apt reporitory attribute

* `default['auditbeat']['apt']['components']` (default: `['stable', 'main']`): beats apt reporitory attribute

* `default['auditbeat']['apt']['uri']` (default: `https://packages.elastic.co/beats/apt`): beats apt reporitory attribute

* `default['auditbeat']['apt']['key']` (default: `http://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats apt reporitory attribute

* `default['auditbeat']['apt']['action']` (default: `:add`): auditbeat apt reporitory attribute


## Other Attributes

* `default['auditbeat']['service']['name']` (default: `auditbeat`): auditbeat service name

* `default['auditbeat']['service']['retries']` (default: `:0`): auditbeat service resource attribute

* `default['auditbeat']['service']['retry_delay']` (default: `:2`): auditbeat service resource attribute


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
[auditbeat]: https://www.elastic.co/guide/en/beats/auditbeat/6.0/auditbeat-overview.html
[Contributors]: https://github.com/vkhatri/chef-auditbeat/graphs/contributors
