openldap-grid Cookbook
======================

This cookbook sets up OpenLDAP client, server and nss-ldapd.

## Contents

- [Requirements](#requirements)
- [Attributes](#attributes)
  - [openldap::default](#openldapdefault)
- [Usage](#usage)
  - [with ssl_cert cookbook](#with-ssl_cert-cookbook)
- [License and Authors](#license-and-authors)

## Requirements

None.

## Attributes

### openldap::default
|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['openldap']['with_ssl_cert_cookbook']`|Boolean|make it work with ssl_cert cookbook. (ver. 0.1.1 or later)|`false`|
|`['openldap']['ssl_cert']['ca_name']`|String|CA name used by ssl_cert (ver. 0.1.1 or later)|`nil`|
|`['openldap']['ssl_cert']['common_name']`|String|Server common name useed by ssl_cert. (ver. 0.1.1 or later)|`node['fqdn']`|
|`['openldap']['client']['URI']`|String|ldap://ldap.example.com ldap://ldap-master.example.com:666|`nil`|
|`['openldap']['client']['BASE']`|String|dc=example,dc=com|`nil`|
|`['openldap']['client']['SIZELIMIT']`|String|12|`nil`|
|`['openldap']['client']['TIMELIMIT']`|String|15|`nil`|
|`['openldap']['client']['DEREF']`|String|never|`nil`|
|`['openldap']['client']['TLS_CACERT']`|String|/etc/ssl/certs/cacert.pem|`nil`|
|`['openldap']['client']['TLS_REQUEST']`|String|never,allow,try,demand*|`nil`|
|`['openldap']['client']['TLS_CHECKPEER']`|String|yes*,no|`nil`|
|`['openldap']['client']['SASL_MECH']`|String|GSSAPI|`nil`|
|`['openldap']['client']['<ldap.conf key>']`|String|other ldap.conf key||
|`['openldap']['nss-ldapd']['uri']`|Strig||`ldap://127.0.0.1/`|
|`['openldap']['nss-ldapd']['base']`|String||`dc=example,dc=net`|
|`['openldap']['nss-ldapd']['<nscd.conf key>']`|String|other nscd.conf key||
|`['openldap']['ldap_lookup_nameservices']`|Array|['passwd', 'group']|`empty`|
|`['openldap']['server']['extra_schema']['samba']`|Boolean|add the schema for Samba (ver. 0.2.3 or later)|`false`|
|`['openldap']['server']['ldaps']`|Boolean|enable ldaps (ver. 0.1.2 or later)|`false`|
|`['openldap']['server']['KRB5_KTNAME']`|String|e.g. `'/etc/krb5.keytab'` (ver. 0.1.2 or later)|`nil`|

## Usage

Just include `openldap-grid::recipe` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[openldap-grid::client]",
    "recipe[openldap-grid::server]",
    "recipe[openldap-grid::nss-ldapd]"
  ]
}
```

### with ssl_cert cookbook

If `node['openldap']['with_ssl_cert_cookbook']` is `true`, `node['openldap']['client']['TLS_CACERT']` and `node['openldap']['nss-ldapd']['tls_cacertfile']` are overridden by the file path based on `['openldap']['ssl_cert']['ca_name']` attribute.

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2013-2017, whitestar

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
