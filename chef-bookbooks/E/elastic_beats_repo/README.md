elastic_beats_repo Cookbook
================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-elastic-beats-repo.svg)](https://github.com/vkhatri/chef-elastic-beats-repo) [![Build Status](https://travis-ci.org/vkhatri/chef-elastic-beats-repo.svg?branch=master)](https://travis-ci.org/vkhatri/chef-elastic-beats-repo)

This is a [Chef] cookbook to manage Elastic Beats YUM/APT [Repository].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/elastic_beats_repo).


## Most Recent Release

```ruby
cookbook 'elastic_beats_repo', '~> 1.2.0'
```


## From Git

```ruby
cookbook 'elastic_beats_repo', github: 'vkhatri/chef-elastic-beats-repo',  tag: 'v1.2.0'
```


## Repository

```
https://github.com/vkhatri/chef-elastic-beats-repo
```


## Supported OS

- Amazon Linux
- CentOS
- Ubuntu
- Debian


## Supported Chef

- Chef 12

- Chef 13


## Supported Elastic Beats Repository

- 1.x
- 5.x


## Cookbook Dependency

- apt
- yum


## Recipes

- `elastic_beats_repo::apt` - configure elastic beats apt repository for node['elastic_beats_repo']['version']

- `elastic_beats_repo::yum` - configure elastic beats yum repository for node['elastic_beats_repo']['version']

- `elastic_beats_repo::default` - platform specific beats repository for node['elastic_beats_repo']['version']

- `elastic_beats_repo::apt_all` - configure elastic beats v1.x and v5.x apt repositories

- `elastic_beats_repo::yum_all` - configure elastic beats v1.x and v5.x yum repositories

- `elastic_beats_repo::default_all` - platform specific v1.x and v5.x beats repositories


## Core Attributes

* `default['elastic_beats_repo']['version']` (default: `5.6.4`): elastic_beats_repo version

* `default['elastic_beats_repo']['setup_repo']` (default: `true`): setup `apt` or `yum` repository if set to `true`


* `default['elastic_beats_repo']['yum']['priority']` (default: `nil`): yum repository attribute

* `default['elastic_beats_repo']['yum']['description']` (default: `Elastic Beats Repository`): yum repository attribute

* `default['elastic_beats_repo']['yum']['gpgcheck']` (default: `true`): yum repository attribute

* `default['elastic_beats_repo']['yum']['enabled']` (default: `true`): yum repository attribute

* `default['elastic_beats_repo']['yum']['baseurl']` (default: `calculated`): yum repository attribute

* `default['elastic_beats_repo']['yum']['gpgkey']` (default: `calculated`): yum repository attribute

* `default['elastic_beats_repo']['yum']['metadata_expire']` (default: `3h`): yum repository attribute

* `default['elastic_beats_repo']['yum']['action']` (default: `:create`): yum repository attribute


* `default['elastic_beats_repo']['apt']['description']` (default: `Elastic Beats Repository`): apt repository attribute

* `default['elastic_beats_repo']['apt']['components']` (default: `['stable', 'main']`): apt repository attribute

* `default['elastic_beats_repo']['apt']['uri']` (default: `calculated`): apt repository attribute

* `default['elastic_beats_repo']['apt']['key']` (default: `calculated`): apt repository attribute

* `default['elastic_beats_repo']['apt']['distribution']` (default: ``): apt repository attribute

* `default['elastic_beats_repo']['apt']['action']` (default: `:add`): apt repository attribute


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
[Repository]: https://www.elastic.co/guide/en/beats/libbeat/current/setup-repositories.html
[Contributors]: https://github.com/vkhatri/chef-elastic-beats-repo/graphs/contributors
