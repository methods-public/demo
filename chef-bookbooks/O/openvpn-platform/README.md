OpenVPN Platform Cookbook
=========================

Description
-----------

OpenVPN is a full-featured open source SSL VPN solution that accommodates
a wide range of configurations, including remote access, site-to-site VPNs,
Wi-Fi security, and enterprise-scale remote access solutions with load
balancing, failover, and fine-grained access-controls.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution, tested on:

- RHEL Family 7, tested on Centos

Usage
-----

### Easy Setup

Add `recipe[openvpn-platform]` in your run-list to install and configure
**OpenVPN Platform** in client or server mode depending on
`node['openvpn-platform']['type']` attribute.

Server configuration will be fetched from resulting merge of following
attributes:
- `node['openvpn-platform']['config']`
- `node['openvpn-platform']['server-config']`.

Client configuration will be fetched from resulting merge of following
attributes:
- `node['openvpn-platform']['config']`
- `node['openvpn-platform']['client-config']`.

Generation of PKI is only handled in server mode with EasyRSA-3. Configuration
can be done via environment variables defined in
`node['openvpn-platform']['easy_rsa']['vars']`

To see an example, look at [.kitchen.yml](.kitchen.yml).

### Data Bags

An optional data bag is available to manage VPN users's client configuration.

Client configuration and key generation is entirely managed.

A tarball will be created in home's user with :
 - OpenVPN client configuration file
 - CA certificate
 - Client certificate
 - Client key
 - TLS Pre Shared Key (optional)

This configuration file is usable with any OpenVPN compatible client for
example on linux desktops with Network Manager (requires a plugin).

You must specify the name of data bag you want to use in
`node['openvpn-platform']['data_bag']`.

#### Users Data Bag

##### Databag Definition

A sample user object would look like :
```json
{
  "id": "user",
  "vpn": "true",
}

```
##### Databag Key Definitions

- `id`: _String_ specifies the username, as well as the data bag object id.
- `vpn`: _Boolean_ specifies if user should have access to VPN.

### Test

This cookbook is fully tested through the installation of a OpenVPN server in
a vagrant host. This uses kitchen and vagrant.

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

Include `package`, `config`, `service`, `users` recipes.

### package

Install **OpenVPN** using package.

### config

Generate and deploy **OpenVPN** client or server config:
 - */etc/openvpn/client/client.conf*
 - */etc/openvpn/server/server.conf*

### service

Enable OpenVPN and make sure service is started.

### users

Generate VPN users's client configuration from data bag items.

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
- Author:: Samuel Bernard(<samuel.bernard@gmail.com>)

```text
Copyright (c) 2017-2018 Make.org

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
