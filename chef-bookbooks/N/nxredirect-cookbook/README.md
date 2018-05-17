NXRedirect Cookbook
===================

Description
-----------

[NXRedirect][nxredirect] acts as a DNS Proxy which redirects NXDomain
responses from a primary DNS server to a fallback. It is primary used to
create split-view architecture where the primary server is internal and the
fallback is public.

This cookbook installs and configures [NXRedirect][nxredirect] as a Systemd
Service. It can (by default) also install *Erlang*, a required dependency.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution:
- RHEL Family 7, tested on Centos

Note: it should work quite fine on Debian 8 (with some attributes tuning) but
the official docker image does not allow Systemd to work easily, so it could
not be tested.

Usage
-----

### Quick Setup

Configure `node['nxredirect-cookbook']['config']` following your needs and
add `recipe[nxredirect-cookbook]` to your run\_list.

A common setup is to collocate [NXRedirect][nxredirect] and a DNS server like
Bind. An example of this setup is presented in [.kitchen.yml](.kitchen.yml) as
the first suite.

### Test

This cookbook is fully tested through test-kitchen and docker.

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Execute the following recipes on a node if
`node['nxredirect-cookbook']['servers']` is empty or contains its hostname.

### erlang

Install Erlang from Erlang Solutions repository.

### install

Install [NXRedirect][nxredirect] in `node['nxredirect-cookbook']['bin']`.

### service

Add and configure Systemd service for [NXRedirect][nxredirect].

Resources/Providers
-------------------

None.

Changelog
---------

Available in [CHANGELOG.md](CHANGELOG.md).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2016 Sam4Mobile, 2017 Make.org

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

[nxredirect]: https://gitlab.com/samuel.bernard/nxredirect
