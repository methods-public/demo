berkshelf-api-server-ya Cookbook
================================

This is yet another berkshelf-api-server cookbook.
This cookbook provides the following extra features to the original cookbook.

- Application server bind address setting.
- HTTPS configurations.
- SSL server key deployment by the Chef Vault.
- Endpoints access user's private key deployment by the Chef Vault.

Requirements
------------

#### packages
- `berkshelf-api-server` - the original cookbook.

Attributes
----------

#### berkshelf-api-server-ya::default added attributes
|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`[:berkshelf_api][:chef_gem][:clear_sources]`|String|chef_gem resource's clear_sources property. (ver. 0.3.2 or later)|`false`|
|`[:berkshelf_api][:chef_gem][:source]`|String|chef_gem resource's source property. (ver. 0.3.2 or later)|`nil`|
|`[:berkshelf_api][:chef_gem][:options]`|String|chef_gem resource's options property. (ver. 0.3.2 or later)|`nil`|
|`[:berkshelf_api][:"chef-vault"][:version]`|String|chef-vault verion (ver. 0.3.4 or later)|`~> 2.6`|
|`[:berkshelf_api][:app_host]`|String|Application sever bind address.|`'0.0.0.0'`|
|`[:berkshelf_api][:proxy][:ssl]`|Boolean|HTTPS enabled.|`false`|
|`[:berkshelf_api][:proxy][:ssl_certificate]`|String|Path to server certificate file.|`''`|
|`[:berkshelf_api][:proxy][:ssl_certificate_key]`|String|Path to server private key file.|`''`|
|`[:berkshelf_api][:proxy][:ssl_certificate_key_vault_item]`|Hash|Chef Vault item read conf. for the server private key. (ver. 0.2.0 or later)|undefined|
|`[:berkshelf_api][:proxy][:ssl_certificate_key_vault_item][:vault]`|String|Vault name|undefined|
|`[:berkshelf_api][:proxy][:ssl_certificate_key_vault_item][:name]`|String|Vault item name|undefined|
|`[:berkshelf_api][:proxy][:ssl_certificate_key_vault_item][:env_context]`|Boolean|for multiple environment settings within encrypted items.|`false`|
|`[:berkshelf_api][:proxy][:ssl_certificate_key_vault_item][:key]`|String|Vault item key (single key or nested hash key path delimited by slash)|undefined|
|`[:berkshelf_api][:config][:endpoints][1..n][:options][:client_key_vault_item]`|Hash|Chef Vault item read conf. for the endpoint access user's private key. (ver. 0.2.0. or later)|undefined|
|`[:berkshelf_api][:config][:endpoints][1..n][:options][:client_key_vault_item][:vault]`|String|Vault name|undefined|
|`[:berkshelf_api][:config][:endpoints][1..n][:options][:client_key_vault_item][:name]`|String|Vault item name|undefined|
|`[:berkshelf_api][:config][:endpoints][1..n][:options][:client_key_vault_item][:env_context]`|Boolean|for multiple environment settings within encrypted items.|`false`|
|`[:berkshelf_api][:config][:endpoints][1..n][:options][:client_key_vault_item][:key]`|String|Vault item key (single key or nested hash key path delimited by slash)|undefined|

Usage
-----

Just include `berkshelf-api-server-ya` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[berkshelf-api-server-ya]"
  ]
}
```

License and Authors
-------------------
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
