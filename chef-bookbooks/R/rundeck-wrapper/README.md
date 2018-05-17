Rundeck Wrapper Cookbook
=============

Description
-----------

Install and configure [Rundeck](http://rundeck.org/) by wrapping cookbook
[rundeck-server][rundeck-server].

This wrapper allows to :

- Generate rundeck users from a data bag.
- Generate nodes file per Chef role.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

Tested on:

- RHEL Family 7, tested on Centos

Usage
-----

### Easy Setup

Add `recipe[rundeck-wrapper]` in your run-list to install and configure
**Rundeck**. Configuration will be fetched from attribute
`node['rundeck_server']`. See cookbook [**rundeck-server**][rundeck-server]
documentation for more information.

To see an example, look at [.kitchen.yml](.kitchen.yml).

### Data Bags

An optional data bag is available to manage rundeck realm users credentials.

You must specify the name of data bag you want to use in
`node['rundeck-wrapper']['data_bag']['realm_users']`.

#### Realm Users Data Bag

It will replaces the following attribute during config recipe :
* `node['rundeck-wrapper']['realm.properties']`.

##### Databag Definition

A sample Realm user object would look like :
```json
{
  "id": "admin",
  "rundeck_password": "admin",
  "groups": [
    "user",
    "admin"
   ]
}

```
##### Databag Key Definitions

- `id`: _String_ specifies the username, as well as the data bag object id.
- `rundeck_password`: _String_ specifies the realm user's password.
- `groups`: _Array_ an array of groups that the realm user will be added to.

### Test

This cookbook is fully tested through the installation of a rundeck server in a
docker host. This uses kitchen and docker.

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

Include `java`, `rundeck-server::default`, `secret`, `node`, recipes.

### java

Install java from distribution package. Is disabled if `install_java` is true
for rundeck\_server.

### secret

Generate and deploy [Rundeck] realm properties users file from data bag :
*realm.properties*.

### node

Generate and deploy nodes files per Chef role declared in attribute
`node['rundeck-wrapper']['nodes_roles']`.

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
[rundeck-server]: https://supermarket.chef.io/cookbooks/rundeck-server
