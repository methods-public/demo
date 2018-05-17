minio-grid Cookbook
===================

This cookbook sets up a Minio service.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [minio-grid::default](#minio-griddefault)
        - [minio-grid::docker-compose](#minio-griddocker-compose)
    - [Role Examples](#role-examples)
    - [SSL server keys and certificates management by `ssl_cert` cookbook](#ssl-server-keys-and-certificates-management-by-ssl_cert-cookbook)
    - [Server access key management by Chef Vault](#server-access-key-management-by-chef-vault)
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
|`['minio-grid']['with_ssl_cert_cookbook']`|Boolean|If this attribute is true, `node['minio-grid']['docker-compose']['config']` are are overridden by the following `common_name` attributes.|`false`|
|`['minio-grid']['ssl_cert']['common_name']`|String|Minio server common name for TLS|`node['fqdn']`|
|`['minio-grid']['docker-compose']['app_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/minio"`|
|`['minio-grid']['docker-compose']['config_dir']`|String||`"#{node['minio-grid']['docker-compose']['app_dir']}/config"`|
|`['minio-grid']['docker-compose']['data_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/data"`|
|`['minio-grid']['docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### minio-grid::default

This recipe does nothing.

#### minio-grid::docker-compose

This recipe generates a `docker-compose.yml` for the Minio service.

### Role Examples

- `roles/minio-on-docker.rb`

```ruby
name 'minio-on-docker'
description 'Minio on Docker'

minio_port = '9000'

run_list(
  'role[docker]',
  'recipe[minio-grid::docker-compose]',
)

#env_run_lists

#default_attributes

override_attributes(
  'minio-grid' => {
    'docker-compose' => {
      'config' => {
        'services' => {
          'minio' => {
            'restart' => 'always',
            'image' => 'minio/minio',
            'ports' => [
              "#{minio_port}:9000",
            ],
            'environment' => {
              # See https://docs.minio.io/
              #'MINIO_REGION' => 'us-east-1',
              #'MINIO_BROWSER' => 'on',
              #'MINIO_DOMAIN' => 'minio.example.com',  # for virtual-host-style requests
              # These variables will be set by the minio-grid::docker-compose recipe automatically.
              #'MINIO_ACCESS_KEY' => '${MINIO_ACCESS_KEY}',
              #'MINIO_SECRET_KEY' => '${MINIO_SECRET_KEY}',
            },
            #'volumes' => [
              # These volumes will be set by the minio-grid::docker-compose recipe automatically.
              #"#{node['minio-grid']['docker-compose']['config_dir']}:/root/.minio:rw",
              #"#{node['minio-grid']['docker-compose']['data_dir']}:/data:rw",
              #"#{server_cert_path(node['minio-grid']['ssl_cert']['common_name'])}:/root/.minio/certs/public.crt:ro",
              #"#{server_key_path(node['minio-grid']['ssl_cert']['common_name'])}:/root/.minio/certs/private.key:ro",
            #],
          },
        },
      },
    },
  },
)
```

- `roles/minio-with-ssl-on-docker.rb`

```ruby
name 'minio-with-ssl-on-docker'
description 'Minio setup with ssl_cert cookbook'

minio_port = '9000'
minio_cn = 'minio.io.example.com'

run_list(
  'role[docker]',
  'recipe[minio-grid::docker-compose]',
)

#env_run_lists

#default_attributes

override_attributes(
  'minio-grid' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => minio_cn,
    },
    'docker-compose' => {
      'config' => {
        'services' => {
          'minio' => {
            'restart' => 'always',
            'image' => 'minio/minio',
            'ports' => [
              "#{minio_port}:9000",
            ],
            'environment' => {
              # See https://docs.minio.io/
              #'MINIO_REGION' => 'us-east-1',
              #'MINIO_BROWSER' => 'on',
              #'MINIO_DOMAIN' => 'minio.example.com',  # for virtual-host-style requests
              # These variables will be set by the minio-grid::docker-compose recipe automatically.
              #'MINIO_ACCESS_KEY' => '${MINIO_ACCESS_KEY}',
              #'MINIO_SECRET_KEY' => '${MINIO_SECRET_KEY}',
            },
            #'volumes' => [
              # These volumes will be set by the minio-grid::docker-compose recipe automatically.
              #"#{node['minio-grid']['docker-compose']['config_dir']}:/root/.minio:rw",
              #"#{node['minio-grid']['docker-compose']['data_dir']}:/data:rw",
              #"#{server_cert_path(node['minio-grid']['ssl_cert']['common_name'])}:/root/.minio/certs/public.crt:ro",
              #"#{server_key_path(node['minio-grid']['ssl_cert']['common_name'])}:/root/.minio/certs/private.key:ro",
            #],
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
$ ruby -rjson -e 'puts JSON.generate({"private" => File.read("minio.io.example.com.prod.key")})' \
> > ~/sec/tmp/minio.io.example.com.prod.key.json

$ ruby -rjson -e 'puts JSON.generate({"public" => File.read("minio.io.example.com.prod.crt")})' \
> > ~/sec/tmp/minio.io.example.com.prod.crt.json

$ cd $CHEF_REPO

$ knife vault create ssl_server_keys minio.io.example.com.prod \
> --json ~/sec/tmp/minio.io.example.com.prod.key.json

$ knife vault create ssl_server_certs minio.io.example.com.prod \
> --json ~/sec/tmp/minio.io.example.com.prod.crt.json
```

- grant reference permission to the Minio host

```text
$ knife vault update ssl_server_keys  minio.io.example.com.prod -S 'name:minio-host.example.com'
$ knife vault update ssl_server_certs minio.io.example.com.prod -S 'name:minio-host.example.com'
```

- modify run_list and attributes

```ruby
run_list(
  'recipe[minio-grid::docker-compose]',
)

override_attributes(
  'minio-grid' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => 'minio.io.example.com',
    },
    # ...
  },
)
```

### Server access key management by Chef Vault

- create vault items.

```text
$ cat ~/sec/tmp/minio_access_key.json
{
  "keyid":"********************",
  "secret":"****************************************"
}

$ cd $CHEF_REPO_PATH
$ knife vault create minio access_key --json ~/sec/tmp/minio_access_key.json
```

- grant reference permission to the minio host

```text
$ knife vault update minio access_key -S 'name:minio-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'minio-grid' => {
    # ...
    'access_key_vault_item' => {
      'vault' => 'minio',
      'name' => 'access_key',
      'env_context' => false,
      'key' => 'keyid',
    },
    'secret_key_vault_item' => {
      'vault' => 'minio',
      'name' => 'access_key',
      'env_context' => false,
      'key' => 'secret',
    },
    # ...
  },
)
```

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2018, whitestar

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
