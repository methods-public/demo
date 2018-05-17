Fail2Ban Platform Cookbook
==========================

Description
-----------

Fail2ban scans log files (e.g. /var/log/apache/error\_log) and bans IPs that
show the malicious signs -- too many password failures, seeking for exploits,
etc. Generally Fail2Ban is then used to update firewall rules to reject the
IP addresses for a specified amount of time, although any arbitrary other
action (e.g. sending an email) could also be configured. Out of the box
Fail2Ban comes with filters for various services (apache, courier, ssh, etc).

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution, tested on:

- RHEL Family 7, tested on Centos

Usage
-----

### Test

This cookbook is fully tested through the installation of a Fail2Ban server in
docker hosts. This uses kitchen and docker.

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

Include `package`, `config`, `systemd` recipes.

### package

Install **Fail2Ban** using package.

### config

Generate and deploy **Fail2Ban** configuration overrides
in following directories if needed:
 - */etc/fail2ban/action.d*
 - */etc/fail2ban/filters.d*
 - */etc/fail2ban/fail2ban.d*
 - */etc/fail2ban/jail.d*

### systemd

Enable Fail2Ban and make sure service is started.

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
Copyright (c) 2018 Make.org

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
