OVH API
========

Description
-----------

Use [OVH API](https://api.ovh.com) to configure your servers, domains, etc.
hosted by [OVH](http://ovh.com). It includes an Ohai plugin used to load
OVH information in automatic attributes.

At the moment, this cookbook can configures the firewall associated to an
IP, the "FTP" backup associated to a dedicated server and the ohai plugin
loads the hardware specifications.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

- Should work on every GNU/Linux and may even work on Windows
- Tested on RHEL Family 7 (centos 7.2)

Usage
-----

### Prerequisite

First, you should get an **application key**, an **application secret** and a
**consumer key** with the necessary rights from OVH. More information on
<https://api.ovh.com/g934.first_step_with_api>.

Then you have to create an encrypted data bag containing these keys. By default
this data bags is named _secrets_ and its item containing the OVH keys is
_ovh-keys_. Its decrypted content should be like:

```json
{
  "id": "ovh-keys",
  "app_key": "my_app_key",
  "app_secret": "my_app_secret",
  "consumer_key": "my_consumer_key"
}
```

Finally do not forget to place the secret keys on the servers.

To verify your setup, add `recipe[ovh-api::init]` in your runlist. If it
converges, your authentification with OVH is correctly configured.

An example of setup is given in
[test/integration/default](test/integration/default) directory.

### Firewall

Add `recipe[ovh-api::firewall]` in your run-list to configure the OVH firewall
for this server. You can configure each IP associated to this server. The
default one can be named _primary_.

Then for each IP, you can enable or disable the firewall and manage the rules.
The configuration syntax is the same as OVH API, for which you can find the
documentation at <https://api.ovh.com/console>.

Finally, you can find an example in [.kitchen.yml](.kitchen.yml).

### Backup

`recipe[ovh-api::backup]` applies two recipes `recipe[ovh-api::backup_api]` and
`recipe[ovh-api::backup_mount]` the first one will activate (or not) any
protocols offered by OVH to access the backup space (FTP, NFS, CIFS).
The second recipe will take care to mount the CIFS or NFS locally.

Note: because it is very complicated to test the mount locally and we only use
CIFS in production, NFS is not recommended.

### Ohai

Add `recipe[ovh-api::ohai]` in your run-list to install and load the Ohai
plugin. It will fetch different information and put them in `node['ovh']`.

### Test

This cookbook is tested in kitchen with the help of
[webmock](https://github.com/bblimke/webmock) to intercept the HTTP REST
calls.

It uses a test cookbook [webmock](test/cookbooks/webmock) by setting
`recipe[webmock::stubs]` and `recipe[webmock::verify]` in the runlist:
**stubs** recipe initializes webmock and create the necessarily stubs while
**verify** recipe dumps all calls so they can later be checked by serverspec.

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Note: for fields needing an IP address, it is possible to set an interface
name, which will be resolved to its first non-local address.

Recipes
-------

### default

Include all other recipes except init and ohai.

### init

Initialize the OVH client.

### firewall

Configure the firewall according to `node['ovh-api']['firewall']`.

### backup

Include backup\_api and backup\_mount recipes.

#### backup\_api

Activate the backup space with protocols defined in
`node['ovh-api']['backup']['protos']`.

#### backup\_mount

Mount the backup space if the protocols are CIFS or NFS.

### ohai

Install and load the Ohai plugin, add OVH information about the server in
`node['ovh']`.

Resources/Providers
-------------------

None.

Changelog
---------

Available in [CHANGELOG](CHANGELOG).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Vincent Baret (<vbaret@gmail.com>)
- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2015-2017 Sam4Mobile, 2017-2018 Make.org

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
