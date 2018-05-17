hc-vault Cookbook
=================

This cookbook sets up a HashiCorp Vault service.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [hc-vault::default](#hc-vaultdefault)
        - [hc-vault::docker-compose](#hc-vaultdocker-compose)
    - [Role Examples](#role-examples)
    - [SSL server keys and certificates management by `ssl_cert` cookbook](#ssl-server-keys-and-certificates-management-by-ssl_cert-cookbook)
- [License and Authors](#license-and-authors)

## Requirements

### platforms

- Debian >= 9.0
- Ubuntu >= 14.04
- CentOS,RHEL >= 7.3

### packages
- none.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['hc-vault']['with_ssl_cert_cookbook']`|Boolean|If this attribute is true, `node['hc-vault']['docker-compose']['config']` are are overridden by the following `common_name` attributes.|`false`|
|`['hc-vault']['ssl_cert']['common_name']`|String|Vault server common name for TLS|`node['fqdn']`|
|`['hc-vault']['config']`|Hash|Vault configurations. This Hash is expanded to a `/vault/config/config.json` in Docker container.|See `attributes/default.rb`|
|`['hc-vault']['docker-compose']['vault_owner']`|Integer|Vault owner UID (read only).|`100`|
|`['hc-vault']['docker-compose']['vault_group']`|Integer|Vault group GID (read only).|`1000`|
|`['hc-vault']['docker-compose']['app_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/vault"`|
|`['hc-vault']['docker-compose']['config_dir']`|String||`"#{node['hc-vault']['docker-compose']['app_dir']}/config"`|
|`['hc-vault']['docker-compose']['file_dir']`|String|Default backend storage.|`"#{node['hc-vault']['docker-compose']['app_dir']}/file"`|
|`['hc-vault']['docker-compose']['logs_dir']`|String||`"#{node['hc-vault']['docker-compose']['app_dir']}/logs"`|
|`['hc-vault']['docker-compose']['certs_dir']`|String||`"#{node['hc-vault']['docker-compose']['app_dir']}/certs"`|
|`['hc-vault']['docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### hc-vault::default

This recipe does nothing.

#### hc-vault::docker-compose

This recipe generates a `docker-compose.yml` for the HashiCorp Vault service.

### Role Examples

- `roles/vault-on-docker.rb`

```ruby
name 'vault-on-docker'
description 'Vault on Docker'

vault_port = '8200'

run_list(
  'role[docker]',
  'recipe[hc-vault::docker-compose]',
)

#env_run_lists()

#default_attributes()

override_attributes(
  'docker-grid' => {
    'engine' => {
      'skip_setup' => false,
    },
    'compose' => {
      'skip_setup' => false,
    },
  },
  'hc-vault' => {
    'config' => {
      #'default_lease_ttl' => '768h',
      #'max_lease_ttl' => '768h',
    },
    'docker-compose' => {
      'config' => {
        # Version 2 docker-compose format
        'version' => '2',
        'services' => {
          'vault' => {
            'ports' => [
              "#{vault_port}:8200",
            ],
            #'volumes' => [
              # These volumes will be set by the hc-vault::docker-compose recipe automatically.
              #"#{node['hc-vault']['docker-compose']['config_dir']}/config.json:/vault/config/config.json:ro",
              #"#{node['hc-vault']['docker-compose']['file_dir']}:/vault/file:rw",
              #"#{node['hc-vault']['docker-compose']['logs_dir']}:/vault/logs:rw",
            #],
            'environment' => {
              # use the ['hc-vault']['config'] attribute instead of this variable.
              #'VAULT_LOCAL_CONFIG' => '',  # expanded to /vault/config/local.json
            },
          },
        },
      },
    },
  },
)
```

- `roles/vault-with-ssl-on-docker.rb`

```ruby
name 'vault-with-ssl-on-docker'
description 'Vault setup with ssl_cert cookbook'

vault_cn = 'vault.io.example.com'
vault_port = '8200'

run_list(
  'role[docker]',
  'recipe[hc-vault::docker-compose]',
)

#env_run_lists()

#default_attributes()

override_attributes(
  'docker-grid' => {
    'engine' => {
      'skip_setup' => false,
    },
    'compose' => {
      'skip_setup' => false,
    },
  },
  'ssl_cert' => {
    #'common_names' => [
    #  vault_cn,  # hc-vault cookbook < 0.1.3
    #],
  },
  'hc-vault' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => vault_cn,
    },
    'config' => {
      'listener' => {
        'tcp' => {
          # These configurations will be set by the hc-vault::docker-compose recipe automatically.
          #'tls_disable' => false
          #'tls_cert_file' => '/vault/server.crt',
          #'tls_key_file' => '/vault/server.key',
        },
      },
      #'default_lease_ttl' => '768h',
      #'max_lease_ttl' => '768h',
    },
    'docker-compose' => {
      'config' => {
        # Version 2 docker-compose format
        'version' => '2',
        'services' => {
          'vault' => {
            'ports' => [
              "#{vault_port}:8200",
            ],
            #'volumes' => [
              # These volumes will be set by the hc-vault::docker-compose recipe automatically.
              #"#{node['hc-vault']['docker-compose']['config_dir']}/config.json:/vault/config/config.json:ro",
              #"#{node['hc-vault']['docker-compose']['file_dir']}:/vault/file:rw",
              #"#{node['hc-vault']['docker-compose']['logs_dir']}:/vault/logs:rw",
              #"#{server_cert_path(node['hc-vault']['ssl_cert']['common_name'])}:/vault/server.crt:ro",
              #"#{node['hc-vault']['docker-compose']['certs_dir']}/server.key:/vault/server.key:ro",
            #],
            'environment' => {
              # use the ['hc-vault']['config'] attribute instead of this variable.
              #'VAULT_LOCAL_CONFIG' => '',  # expanded to /vault/config/local.json
            },
          },
        },
      },
    },
  },
)
```

### SSL server keys and certificates management by `ssl_cert` cookbook

- create chef-vault items.

```text
$ ruby -rjson -e 'puts JSON.generate({"private" => File.read("vault.io.example.com.prod.key")})' \
> > ~/tmp/vault.io.example.com.prod.key.json

$ ruby -rjson -e 'puts JSON.generate({"public" => File.read("vault.io.example.com.prod.crt")})' \
> > ~/tmp/vault.io.example.com.prod.crt.json

$ cd $CHEF_REPO

$ knife vault create ssl_server_keys vault.io.example.com.prod \
> --json ~/tmp/vault.io.example.com.prod.key.json

$ knife vault create ssl_server_certs vault.io.example.com.prod \
> --json ~/tmp/vault.io.example.com.prod.crt.json
```

- grant reference permission to the Vault host

```text
$ knife vault update ssl_server_keys  vault.io.example.com.prod -S 'name:vault-host.example.com'
$ knife vault update ssl_server_certs vault.io.example.com.prod -S 'name:vault-host.example.com'
```

- modify run_list and attributes

```ruby
run_list(
  'recipe[hc-vault::docker-compose]',
)

override_attributes(
  'ssl_cert' => {
    #'common_names' => [
    #  'vault.io.example.com',  # hc-vault cookbook < 0.1.3
    #],
  },
  'hc-vault' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => 'vault.io.example.com',
    },
    # ...
  },
)
```

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2017, whitestar

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
