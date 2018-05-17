UGId Management
===============

Description
-----------

Library cookbook to manage user and group ids. More specifically, it can
apply and check that all listed uids and gids are synchronized between servers.

Moreover, it is also a wrapper around [users cookbook][users_cookbook] to
create users and groups with specified uids/gids.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

- RHEL Family 7, tested on Centos

Note: it should work on any Linux system but it is only tested on Centos 7.

Usage
-----

### Quick Start

Basically, this cookbook need two data bags:

1. one for specifying uids and gids (grouped under the name ugid) named *ugids*
2. one to override user creation in packages named *packages*

You can find example of theses data bags in
[test/data\_bags/ugids](test/data_bags/ugids) directory.

#### ugids

So in *ugids*, you can find the list of forced ugids. It has a simple format:

```json
{
  "id": "ugids",
  "ugids": {
    "a_given_username": "its_uid:its_gid",
    "examble": "123:234",
    "an_integer_is_also_accepted_for_specifying_both": 234,
    "if_you_only_want_a_gid": ":234"
  }
}
```

Each time a Chef resource user or group is used, it got extended with these
uids and gids. If no ugid are defined, an exception is thrown, failing the
Chef run.

#### packages

The role of *packages* is to override the user creations performed in
distribution packages (like deb/rpm). Its format is:

```json
{
  "id": "packages",
  "packages": {
    "package_name": {
      "username": "username",
      "user_opts": {
        "extra_key": "extra_value"
      },
      "group_opts": {
        "extra_key": "extra_value"
      }
    },
    "example": {
      "username": "username_to_create",
      "user_opts": {
        "home": "/var/lib/specific_home",
        "shell": "/sbin/typically-nologin"
      },
      "group_opts": {
        "append": true
      }
    }
  }
}
```

Warning: if a package does not have an user defined in this package, it is
untouched by Chef. This could lead to uncontrolled users. That is why you can
activate the verification (active in default recipe).

#### Verification

**check** recipe uses *ugids* data bag to verify if each user/group with a
uid/gid greater than 200 (non system-reserved) has the correct uid/gid.

By default, all users/groups must have an *ugid* defined but it is possible to
deactivate this behavior with `node[cookbook_name]['enforce']`
attribute. It is also possible to defined a whitelist (like for systemd users)
with `node[cookbook_name]['whitelist']` (applicable for both users and groups).

### logindefs

This cookbook can also configure `/etc/login.defs` with values defined from
attributes.

### Users creation

Recipe [create](recipes/create.rb) is a wrapper around users cookbook. To use
it, create a data bag *users* containing your users, as specified by the
[users cookbook][users_cookbook]. Then declare the groups you want to install
in `node['ugid-management']['users_manage']` attribute, as an array. Of course,
*ugids* data bag should also include the correct information.

### Test

This cookbook is fully tested through the installation of a working node in
docker.

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

Include *logindefs*, *create*, *manage\_before*, *manage\_after* and
*check* (only if check is activated) in this order.

### create

Use users cookbook (as dependency) to create groups and their associated users.
User creation is controled by `users_manage` attribute which lists all groups
that will be installed. Users should be listed in *users* data bag. See
[users cookbook][users_cookbook] for more information.

### logindefs

Manage `/etc/login.defs` with values defined in attributes.

### manage\_before and manage\_after

Manage users (extending user/group resources with defined ugids) and
packages (creating package user/group before the package to control their
attributes).

The difference between *manage\_before* and *manage\_after* is that
*manage\_before* manages all resources which are executed before in the Chef
run while *manage\_after* managers the resources after. Combining them, like
in *default* recipe, allows you to manage all resources independently of
their positions in the run list.

### check

Check if all users and groups are correctly defined on the system. Raise an
exception and fail the Chef run if it is not the case.

Resources/Providers
-------------------

None.

Libraries
---------

### default

Define all methods needed for user management.

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
Copyright (c) 2016 Sam4Mobile, 2017-2018 Make.org

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

[users_cookbook]: https://github.com/chef-cookbooks/users
