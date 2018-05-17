cobbpass Cookbook
=================

This cookbook creates a local user and applies a random password to it. The
user has root permissions and works as a fallback user.

The user password can be automatically changed every day or on every chef
run. This way if the remote user is unavailable (e.g. when a LDAP server
is malfunctioning), the administrator can lookup the password and login
into the server.

The random password is stored using chef-vault, and only the actual node
and the administrators can see the encrypted passwords inside it.

Requirements
============

Cookbooks
---------

The following cookbooks are dependencies for this:

* sudo - sets the root permissions for the user
* chef-vault - for encrypting and storing passwords

Platform
--------

The following platforms are supported and tested:

* CentOS 6.7
* CentOS 7.2

Chef Server
-----------

The recommended chef version is at least >= 12.5

Databag setup
=============

Create the data bag in which you will store the passwords:

```bash
knife data bag create cobbpass
```

Clients (nodes) must be able to create, update and read databag items:

```
knife acl add group clients data cobbpass read,update,create
```

Usage
=====

To use the cookbook, you can just add the `default` recipe to the run\_list. It
will setup the user and its random password. By default, on every chef run, the
password will be changed.

If you don't want to change the password on every chef run, remove from the 
run\_list and add a cron entry to run only this recipe:

```bash
chef-client -o 'recipe[cobbpass]'
```

It will create the vault item under `cobbpass/<node>` and the username on the
server will be `cobbpass`.

Currently, chef doesn't allow node clients to see user public keys, so we
can't specify any admin on the vault. Instead, we can create a _dummy_ client
and and allow all other clients to see it:

```bash
knife client create cobbpass
knife acl add group clients clients cobbpass read
knife node create cobbpass
knife acl add group clients nodes cobbpass read
```

This way you can specify pseudo-admins using their clients names on the 
attribute.

Attributes
==========

Attributes are documented on `attributes/default.rb` file. This way I don't need
to duplicate definitions here and there :)

License and Author
==================

- Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)

Copyright 2017, Movile

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
