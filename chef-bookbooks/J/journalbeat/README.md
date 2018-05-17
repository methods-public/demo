JournalBeat Cookbook
=============

Description
-----------
[Journalbeat](https://github.com/mheese/journalbeat) is the Beat used for log
shipping from systemd/journald based Linux systems.

This cookbook is designed to install and configure JournalBeat daemon.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

Should work on many *systemd* managed distribution, tested on:

- RHEL Family 7, tested on Centos

Usage
-----

### Test

This cookbook is fully tested through the installation of journalbeat and
logstash in a docker host. This uses kitchen and docker.

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

Include `user`, `install`, `config`, `systemd` recipes.

### user

Create user/group used by **Journalbeat**.

### install

Install **JournalBeat** by fetching official release repository.

### config

Generate and deploy **JournalBeat** config : *journalbeat.yml*.

### systemd

Create Systemd unit for **JournalBeat** and make sure service is started.


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

- Author:: Sylvain Arrambourg (<saye@sknss.net>)
- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2017 Make.org

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
