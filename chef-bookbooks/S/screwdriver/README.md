screwdriver Cookbook
====================

This cookbook sets up a Screwdriver CI/CD service by Docker Compose.

## Contents

- [Contents](#contents)
- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
    - [cookbooks](#cookbooks)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [screwdriver::default](#screwdriverdefault)
        - [screwdriver::docker-compose](#screwdriverdocker-compose)
    - [Role Examples](#role-examples)
    - [SSL server keys and certificates management by ssl_cert cookbook](#ssl-server-keys-and-certificates-management-by-ssl_cert-cookbook)
    - [JWT private and public keys management by Chef Vault](#jwt-private-and-public-keys-management-by-chef-vault)
    - [Cookie password management by Chef Vault](#cookie-password-management-by-chef-vault)
    - [Secrets encryption password management by Chef Vault](#secrets-encryption-password-management-by-chef-vault)
    - [Database username management (for MySQL, PostgreSQL,...) by Chef Vault](#database-username-management-for-mysql-postgresql-by-chef-vault)
    - [Database password management (for MySQL, PostgreSQL,...) by Chef Vault](#database-password-management-for-mysql-postgresql-by-chef-vault)
    - [Database root password management (for MySQL, PostgreSQL,...) by Chef Vault](#database-root-password-management-for-mysql-postgresql-by-chef-vault)
    - [S3 (compatible) server access key management by Chef Vault](#s3-compatible-server-access-key-management-by-chef-vault)
    - [OAuth client ID, secret and GitHub webhook secret management by Chef Vault](#oauth-client-id-secret-and-github-webhook-secret-management-by-chef-vault)
    - [Note](#note)
        - [Database Initialization](#database-initialization)
- [License and Authors](#license-and-authors)

## Requirements

### platforms
- Debian >= 9.0
- Ubuntu >= 14.04
- CentOS, RHEL >= 7.3

### packages
- none.

### cookbooks
- `docker-grid`
- `ssl_cert`

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['screwdriver']['with_ssl_cert_cookbook']`|Boolean|See `attributes/default.rb`|`false`|
|`['screwdriver']['ssl_cert']['ca_names']`|Array|Internal CA names that are imported by the ssl_cert cookbook.|`[]`|
|`['screwdriver']['ssl_cert']['common_name']`|String|Server common name for TLS|`node['fqdn']`|
|`['screwdriver']['jwt_private_key_vault_item']`|Hash|Optional, Sets a JWT private key from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['jwt_public_key_vault_item']`|Hash|Optional, Sets a JWT public key from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['cookie_password_vault_item']`|Hash|Optional, Sets a session cookie password from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['password_vault_item']`|Hash|Optional, Sets a password for secrets encryption from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['db_username_vault_item']`|Hash|Optional, Sets a database username from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['db_password_vault_item']`|Hash|Optional, Sets a database password from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['db_root_password_vault_item']`|Hash|Optional, Sets a database password for the root user from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['s3_access_key_id_vault_item']`|Hash|Optional, Sets a S3 access key id from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['s3_access_key_secret_vault_item']`|Hash|Optional, Sets a S3 access key secret from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['ui']['tls_setup_mode']`|String|`'reverseproxy'` only. Note: [_Add TLS support to UI docker container #377_](https://github.com/screwdriver-cd/screwdriver/issues/377)|`'reverseproxy'`|
|`['screwdriver']['api']['config']`|Hash|This hash object is expanded to a `/config/local.yaml` file in the API Docker container.|See `attributes/default.rb`|
|`['screwdriver']['api']['scms_vault_items']`|Hash|This hash contains Chef Vault item definitions of SCM's secrets.|See `attributes/default.rb`|
|`['screwdriver']['store']['backend']`|String|`nil` (in memory) or `'minio'`.|`nil`|
|`['screwdriver']['store']['config']`|Hash|This hash object is expanded to a `/config/local.yaml` file in the Store Docker container.|See `attributes/default.rb`|
|`['screwdriver']['docker-compose']['import_ca']`|Boolean|whether import internal CA certificates or not.|`false`|
|`['screwdriver']['docker-compose']['app_dir']`|String|Path string.|`"#{node['docker-grid']['compose']['app_dir']}/screwdriver"`|
|`['screwdriver']['docker-compose']['bin_dir']`|String|Path string.|`"#{node['screwdriver']['docker-compose']['app_dir']}/bin"`|
|`['screwdriver']['docker-compose']['config_dir']`|String|Path string.|`"#{node['screwdriver']['docker-compose']['app_dir']}/config"`|
|`['screwdriver']['docker-compose']['data_dir']`|String|Path string.|`"#{node['screwdriver']['docker-compose']['app_dir']}/data"`|
|`['screwdriver']['docker-compose']['etc_dir']`|String|Path string.|`"#{node['screwdriver']['docker-compose']['app_dir']}/etc"`|
|`['screwdriver']['docker-compose']['jwt_private_key_reset']`|Boolean|Only available if the JWT key pair is automatically generated by Chef.|`false`|
|`['screwdriver']['docker-compose']['jwt_private_key_vault_item']`|Hash|**DEPRECATED**: use `['screwdriver']['jwt_private_key_vault_item']`. Optional, Sets a JWT private key from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['docker-compose']['jwt_public_key_vault_item']`|Hash|**DEPRECATED**: use `['screwdriver']['jwt_public_key_vault_item']`. Optional, Sets a JWT public key from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['docker-compose']['cookie_password_vault_item']`|Hash|**DEPRECATED**: use `['screwdriver']['cookie_password_vault_item']`. Optional, Sets a session cookie password from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['docker-compose']['password_vault_item']`|Hash|**DEPRECATED**: use `['screwdriver']['password_vault_item']`. Optional, Sets a password for secrets encryption from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['docker-compose']['oauth_client_id_vault_item']`|Hash|**DEPRECATED**: use `['screwdriver']['api']['scms_vault_items']`. Required, Sets a OAuth client ID for SCM from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['docker-compose']['oauth_client_secret_vault_item']`|Hash|**DEPRECATED**: use `['screwdriver']['api']['scms_vault_items']`. Required, Sets a OAuth secret for SCM from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['docker-compose']['webhook_github_secret_vault_item']`|Hash|**DEPRECATED**: use `['screwdriver']['api']['scms_vault_items']`. Required for GitHub, Sets a secret for GitHub webhook from Chef Vault. See `attributes/default.rb`|`{}`|
|`['screwdriver']['docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### screwdriver::default

This recipe does nothing.

#### screwdriver::docker-compose

This recipe generates JWT key pair and a `docker-compose.yml` file for the Screwdriver CI/CD service.

### Role Examples

- `roles/screwdriver.rb`

```ruby
name 'screwdriver'
description 'screwdriver'

ui_port     = '9000'
api_port    = '9001'
store_port  = '9002'

run_list(
  'role[docker]',
  'recipe[screwdriver::docker-compose]',
)

override_attributes(
  'screwdriver' => {
    'api' => {
      'config' => {
        'executor' => {
          'plugin' => 'docker',
          'docker' => {
            'options' => {
              'docker' => {
                'socketPath' => '/var/run/docker.sock',
              },
              'launchVersion' => 'stable',
            },
          },
        },
        'scms' => {
          'github.com' => {
            'plugin' => 'github',
            'config' => {
              # OAuth Callback URL: "http://#{node['fqdn']}:9001/v4/auth/login/web"
              'username' => 'ci-tool',
              'email' => 'citool@mail.example.com',
              'privateRepo' => false,
            },
          },
        },
      },
      'scms_vault_items' => {
        'github.com' => {
          'oauthClientId' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'oauthClientId',  # real hash path: "/oauthClientId"
          },
          'oauthClientSecret' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'oauthClientSecret',  # real hash path: "/oauthClientSecret"
          },
          'secret' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'secret',  # real hash path: "/secret"
          },
        },
      },
    },
    'docker-compose' => {
      'config' => {
        'services' => {
          'api' => {
            'ports' => [
              "#{api_port}:80",
            ],
            'environment' => {
              'NODE_TLS_REJECT_UNAUTHORIZED' => '0',  # for self-signed cetificates
              # The following variables will be set by the screwdriver::docker-compose recipe automatically.
              #'ECOSYSTEM_UI' => "http://#{node['fqdn']}:#{ui_port}",
              #'ECOSYSTEM_STORE' => "http://#{node['fqdn']}:#{store_port}",
            },
          },
          'ui' => {
            'ports' => [
              "#{ui_port}:80",
            ],
            'environment' => {
              # These variables will be set by the screwdriver::docker-compose recipe automatically.
              #'ECOSYSTEM_API' => "http://#{node['fqdn']}:#{api_port}",
              #'ECOSYSTEM_STORE' => "http://#{node['fqdn']}:#{store_port}",
            },
          },
          'store' => {
            'ports' => [
              "#{store_port}:80",
            ],
            'environment' => {
              # This variable will be set by the screwdriver::docker-compose recipe automatically.
              #'ECOSYSTEM_UI' => "http://#{node['fqdn']}:#{ui_port}",
            },
          },
        },
      },
    },
  },
)
```

- `roles/screwdriver-with-ssl.rb`

```ruby
name 'screwdriver-with-ssl'
description 'screwdriver with SSL'

cn = 'screwdriver.io.example.com'
ui_port     = '9000'
api_port    = '9001'
store_port  = '9002'

run_list(
  'role[docker]',
  'recipe[screwdriver::docker-compose]',
)

override_attributes(
  'ssl_cert' => {
    #'common_names' => [
    #  cn,  # screwdriver cookbook < 0.2.2
    #],
  },
  'screwdriver' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => cn,
    },
    'api' => {
      'config' => {
        'executor' => {
          'plugin' => 'docker',
          'docker' => {
            'options' => {
              'docker' => {
                'socketPath' => '/var/run/docker.sock',
              },
              'launchVersion' => 'stable',
            },
          },
        },
        'scms' => {
          'github.com' => {
            'plugin' => 'github',
            'config' => {
              # OAuth Callback URL: "http://#{node['fqdn']}:9001/v4/auth/login/web"
              'username' => 'ci-tool',
              'email' => 'citool@mail.example.com',
              'privateRepo' => false,
            },
          },
        },
      },
      'scms_vault_items' => {
        'github.com' => {
          'oauthClientId' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'oauthClientId',  # real hash path: "/oauthClientId"
          },
          'oauthClientSecret' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'oauthClientSecret',  # real hash path: "/oauthClientSecret"
          },
          'secret' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'secret',  # real hash path: "/secret"
          },
        },
      },
    },
    'docker-compose' => {
      'config' => {
        'services' => {
          'reverseproxy' => {
            'ports' => [
              "#{ui_port}:9000",
            ],
            'environment' => {
            },
          },
          'api' => {
            'ports' => [
              "#{api_port}:80",
            ],
            'environment' => {
              'NODE_TLS_REJECT_UNAUTHORIZED' => '0',  # for self-signed cetificates
              # The following variables will be set by the screwdriver::docker-compose recipe automatically.
              #'ECOSYSTEM_UI' => "http://#{node['fqdn']}:#{ui_port}",
              #'ECOSYSTEM_STORE' => "http://#{node['fqdn']}:#{store_port}",
            },
          },
          'ui' => {
            #'ports' => [
            #  "#{ui_port}:80",
            #],
            'environment' => {
              # These variables will be set by the screwdriver::docker-compose recipe automatically.
              #'ECOSYSTEM_API' => "http://#{node['fqdn']}:#{api_port}",
              #'ECOSYSTEM_STORE' => "http://#{node['fqdn']}:#{store_port}",
            },
          },
          'store' => {
            'ports' => [
              "#{store_port}:80",
            ],
            'environment' => {
              # These variables will be set by the screwdriver::docker-compose recipe automatically.
              #'ECOSYSTEM_UI' => "http://#{node['fqdn']}:#{ui_port}",
            },
          },
        },
      },
    },
  },
)
```

### SSL server keys and certificates management by ssl_cert cookbook

- create vault items.

```text
$ ruby -rjson -e 'puts JSON.generate({"private" => File.read("screwdriver.io.example.com.prod.key")})' \
> > ~/sec/tmp/screwdriver.io.example.com.prod.key.json

$ ruby -rjson -e 'puts JSON.generate({"public" => File.read("screwdriver.io.example.com.prod.crt")})' \
> > ~/sec/tmp/screwdriver.io.example.com.prod.crt.json

$ cd $CHEF_REPO_PATH

$ knife vault create ssl_server_keys screwdriver.io.example.com.prod \
> --json ~/sec/tmp/screwdriver.io.example.com.prod.key.json

$ knife vault create ssl_server_certs screwdriver.io.example.com.prod \
> --json ~/sec/tmp/screwdriver.io.example.com.prod.crt.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update ssl_server_keys  screwdriver.io.example.com.prod -S 'name:screwdriver-host.example.com'
$ knife vault update ssl_server_certs screwdriver.io.example.com.prod -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'ssl_cert' => {
    #'common_names' => [
    #  'screwdriver.io.example.com',  # screwdriver cookbook < 0.2.2
    #],
  },
  'screwdriver' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => 'screwdriver.io.example.com',
    },
    # ...
  },
)
```

### JWT private and public keys management by Chef Vault

- create vault items.

```text
$ ruby -rjson -e 'puts JSON.generate({"private" => File.read("screwdriver_jwt_private.key")})' \
> > ~/sec/tmp/screwdriver_jwt_private.key.json

$ ruby -rjson -e 'puts JSON.generate({"public" => File.read("screwdriver_jwt_public.key")})' \
> > ~/sec/tmp/screwdriver_jwt_public.key.json

$ cd $CHEF_REPO_PATH

$ knife vault create screwdriver jwt_private_key \
> --json ~/sec/tmp/screwdriver_jwt_private.key.json

$ knife vault create screwdriver screwdriver_jwt_public \
> --json ~/sec/tmp/screwdriver_jwt_public.key.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver jwt_private_key -S 'name:screwdriver-host.example.com'
$ knife vault update screwdriver jwt_public_key  -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    'jwt_private_key_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 'jwt_private_key',
      'env_context' => false,
      'key' => 'private',
    },
    'jwt_public_key_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 'jwt_public_key',
      'env_context' => false,
      'key' => 'public',
    },
    # ...
  },
)
```

### Cookie password management by Chef Vault

- create vault items.

```text
# A password used for encrypting session data. Needs to be minimum 32 characters
$ cat ~/sec/tmp/screwdriver_cookie_password.json
{"password":"********************************"}

$ cd $CHEF_REPO_PATH
$ knife vault create screwdriver cookie_password --json ~/sec/tmp/screwdriver_cookie_password.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver cookie_password -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    'cookie_password_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 'cookie_password',
      'env_context' => false,
      'key' => 'password',
    },
    # ...
  },
)
```

### Secrets encryption password management by Chef Vault

- create vault items.

```text
# A password used for encrypting stored secrets. Needs to be minimum 32 characters
$ cat ~/sec/tmp/screwdriver_password.json
{"password":"********************************"}

$ cd $CHEF_REPO_PATH
$ knife vault create screwdriver password --json ~/sec/tmp/screwdriver_password.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver password -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    'password_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 'password',
      'env_context' => false,
      'key' => 'password',
    },
    # ...
  },
)
```

### Database username management (for MySQL, PostgreSQL,...) by Chef Vault

- create vault items.

```text
$ cat ~/sec/tmp/screwdriver_db_username.json
{"username":"********************************"}

$ cd $CHEF_REPO_PATH
$ knife vault create screwdriver db_username --json ~/sec/tmp/screwdriver_db_username.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver db_username -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    'db_username_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 'db_username',
      'env_context' => false,
      'key' => 'username',
    },
    # ...
  },
)
```

### Database password management (for MySQL, PostgreSQL,...) by Chef Vault

- create vault items.

```text
$ cat ~/sec/tmp/screwdriver_db_password.json
{"password":"********************************"}

$ cd $CHEF_REPO_PATH
$ knife vault create screwdriver db_password --json ~/sec/tmp/screwdriver_db_password.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver db_password -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    'db_password_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 'db_password',
      'env_context' => false,
      'key' => 'password',
    },
    # ...
  },
)
```

### Database root password management (for MySQL, PostgreSQL,...) by Chef Vault

- create vault items.

```text
$ cat ~/sec/tmp/screwdriver_db_root_password.json
{"password":"********************************"}

$ cd $CHEF_REPO_PATH
$ knife vault create screwdriver db_root_password --json ~/sec/tmp/screwdriver_db_root_password.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver db_root_password -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    'db_root_password_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 'db_root_password',
      'env_context' => false,
      'key' => 'password',
    },
    # ...
  },
)
```

### S3 (compatible) server access key management by Chef Vault

- create vault items.

```text
$ cat ~/sec/tmp/screwdriver_s3_access_key.json
{
  "kid":"********************",
  "secret":"****************************************"
}

$ cd $CHEF_REPO_PATH
$ knife vault create screwdriver s3_access_key --json ~/sec/tmp/screwdriver_s3_access_key.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver s3_access_key -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    's3_access_key_id_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 's3_access_key',
      'env_context' => false,
      'key' => 'kid',
    },
    's3_access_key_secret_vault_item' => {
      'vault' => 'screwdriver',
      'name' => 's3_access_key',
      'env_context' => false,
      'key' => 'secret',
    },
    # ...
  },
)
```

### OAuth client ID, secret and GitHub webhook secret management by Chef Vault

- create vault items.

```text
$ cat ~/sec/tmp/screwdriver_github_secrets.json
{
  "oauthClientId": "***************************************************************",
  "oauthClientSecret": "***************************************************************",
  "secret": "**************************"
}
```

$ cd $CHEF_REPO_PATH

```text
$ knife vault create screwdriver github --json ~/sec/tmp/screwdriver_github_secrets.json
```

- grant reference permission to the screwdriver host

```text
$ knife vault update screwdriver github -S 'name:screwdriver-host.example.com'
```

- modify attributes

```ruby
override_attributes(
  'screwdriver' => {
    # ...
    'api' => {
      # ...
      'scms_vault_items' => {
        'github.com' => {
          'oauthClientId' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'oauthClientId',  # real hash path: "/oauthClientId"
          },
          'oauthClientSecret' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'oauthClientSecret',  # real hash path: "/oauthClientSecret"
          },
          'secret' => {
            'vault' => 'screwdriver',
            'name' => 'github',
            'env_context' => false,
            'key' => 'secret',  # real hash path: "/secret"
          },
        },
      },
    },
    # ...
  },
)
```

### Note

#### Database Initialization

If you use database other than sqlite, its database initialization will takes a few tens of seconds.
You should run a database container only at the beginning and then start the others. 

```
$ sudo docker-compose up -d db
...
Creating network "screwdriver_default" with the default driver
Creating screwdriver_db_1 ... done

$ sudo docker-compose up -d
screwdriver_db_1 is up-to-date
Creating screwdriver_api_1   ... done
Creating screwdriver_ui_1    ... done
Creating screwdriver_store_1 ... done
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
