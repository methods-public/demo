gitlab-grid Cookbook
=====================

This cookbook sets up a GitLab server.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [gitlab-grid::default](#gitlab-griddefault)
        - [gitlab-grid::server](#gitlab-gridserver)
        - [gitlab-grid::docker-compose](#gitlab-griddocker-compose)
        - [gitlab-grid::runner-docker-compose](#gitlab-gridrunner-docker-compose)
    - [Role Examples](#role-examples)
    - [Internal CA certificates management by ssl_cert cookbook](#internal-ca-certificates-management-by-ssl_cert-cookbook)
    - [SSL server keys and certificates management by ssl_cert cookbook](#ssl-server-keys-and-certificates-management-by-ssl_cert-cookbook)
- [License and Authors](#license-and-authors)

## Requirements

### platforms
- none.

### packages
- none.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['gitlab-grid']['with_ssl_cert_cookbook']`|Boolean|If this attribute is true, CA certificate and server key pairs are deployed and the `node['gitlab-grid']['gitlab.rb']` settings are overridden by the following `common_name` attributes.|`false`|
|`['gitlab-grid']['ssl_cert']['ca_name']`|String|Internal CA name that signs server certificates.|`nil`|
|`['gitlab-grid']['ssl_cert']['common_name']`|String|GitLab server common name for TLS|`node['fqdn']`|
|`['gitlab-grid']['ssl_cert']['registry']['reuse_gitlab_common_name']`|Boolean|Reuse GitLab domain (same common name) for TLS|`false`|
|`['gitlab-grid']['ssl_cert']['registry']['common_name']`|String|Container registry service's unique common name for TLS|`nil`|
|`['gitlab-grid']['gitlab.rb']`|Hash|`gitlab.rb` configurations.|See `attributes/default.rb`|
|`['gitlab-grid']['gitlab.rb_extra_config_str']`|String|`gitlab.rb` extra configuration string (source code in Ruby).|`nil`|
|`['gitlab-grid']['runner-docker-compose']['import_ca']`|Boolean|Import an internal CA certificate to a gitlab-runner container or not.|`false`|
|`['gitlab-grid']['runner-docker-compose']['app_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/gitlab-runner"`|
|`['gitlab-grid']['runner-docker-compose']['etc_dir']`|String||`"#{node['gitlab-grid']['runner-docker-compose']['app_dir']}/etc"`|
|`['gitlab-grid']['runner-docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### gitlab-grid::default

This recipe does nothing.

#### gitlab-grid::server

This recipe sets up a GitLab server.

#### gitlab-grid::docker-compose

This recipe generates a `docker-compose.yml` for the GitLab server.

#### gitlab-grid::runner-docker-compose

This recipe generates a `docker-compose.yml` for the gitlab-runner.

### Role Examples

- `roles/gitlab.rb`

```ruby
name 'gitlab'
description 'GitLab'

run_list(
  'recipe[gitlab-grid::server]',
)

#env_run_lists()

#default_attributes()

gitlab_cn = 'gitlab.io.example.com'

override_attributes(
  'gitlab-grid' => {
    # See https://docs.gitlab.com/omnibus/settings/configuration.html
    'gitlab.rb' => {
      'external_url' => "http://#{gitlab_cn}",
      'gitlab_rails' => {
        'time_zone' => 'Asia/Tokyo',
      },
    },
  },
)
```

- `roles/gitlab-with-ssl-cert.rb`

```ruby
name 'gitlab-with-ssl-cert'
description 'GitLab setup with ssl_cert cookbook'

run_list(
  #'recipe[ssl_cert::server_key_pairs]',  # gitlab-grid cookbook < 0.1.4
  'recipe[gitlab-grid::server]',
)

#env_run_lists()

#default_attributes()

gitlab_cn = 'gitlab.io.example.com'

override_attributes(
  'ssl_cert' => {
    #'common_names' => [
    #  gitlab_cn,  # gitlab-grid cookbook < 0.1.6
    #],
  },
  'gitlab-grid' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => gitlab_cn,
    },
    'gitlab.rb' => {
      'external_url' => "https://#{gitlab_cn}",
      'gitlab_rails' => {
        'time_zone' => 'Asia/Tokyo',
      },
      'nginx' => {
        'redirect_http_to_https' => true,
      },
    },
  },
)
```

- `roles/gitlab-on-docker.rb`

```ruby
name 'gitlab-on-docker'
description 'GitLab on Docker'

gitlab_cn = 'gitlab.io.example.com'
gitlab_http_port = '8080'
gitlab_ssh_port = '2022'

run_list(
  'role[docker]',
  'recipe[gitlab-grid::docker-compose]',
)

#env_run_lists()

#default_attributes()

override_attributes(
  'gitlab-grid' => {
    'gitlab.rb' => {
      'external_url' => "http://#{gitlab_cn}:#{gitlab_http_port}",
      'gitlab_rails' => {
        'time_zone' => 'Asia/Tokyo',
        'gitlab_shell_ssh_port' => gitlab_ssh_port.to_i,
      },
      'nginx' => {
        'redirect_http_to_https' => false,
      },
    },
    'docker-compose' => {
      'config' => {
        # Version 2 docker-compose format
        'version' => '2',
        'services' => {
          'gitlab' => {
            'restart' => 'always',
            'image' => 'gitlab/gitlab-ce:latest',
            'hostname' => gitlab_cn,
            'ports' => [
              "#{gitlab_http_port}:#{gitlab_http_port}",
              "#{gitlab_ssh_port}:22",
            ],
            'environment' => {
            },
            #'volumes' => [
            #],
          },
        },
      },
    },
  },
)
```

- `roles/gitlab-with-ssl-on-docker.rb`: and activates Container registry feature.

```ruby
name 'gitlab-with-ssl-on-docker'
description 'GitLab with SSL on Docker'

gitlab_cn = 'gitlab.io.example.com'
gitlab_https_port = '8443'
gitlab_ssh_port = '2022'
gitlab_registry_port = '5050'

run_list(
  #'recipe[ssl_cert::server_key_pairs]',  # gitlab-grid cookbook < 0.1.4
  'role[docker]',
  'recipe[gitlab-grid::docker-compose]',
)

#env_run_lists()

#default_attributes()

override_attributes(
  'ssl_cert' => {
    #'common_names' => [
    #  gitlab_cn,  # gitlab-grid cookbook < 0.1.6
    #],
  },
  'gitlab-grid' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => gitlab_cn,
      'registry' => {
        'reuse_gitlab_common_name' => true,
        # or
        #'reuse_gitlab_common_name' => false,
        #'common_name' => registry_gitlab_cn,
      },
    },
    'gitlab.rb' => {
      'external_url' => "https://#{gitlab_cn}:#{gitlab_https_port}",
      'registry_external_url' => "https://#{gitlab_cn}:#{gitlab_registry_port}",  # Do not use 5000 if same domain (common name)
      'gitlab_rails' => {
        'time_zone' => 'Asia/Tokyo',
        'gitlab_shell_ssh_port' => gitlab_ssh_port.to_i,
      },
      'nginx' => {
        'redirect_http_to_https' => true,
      },
      'registry_nginx' => {
        'redirect_http_to_https' => true,
      },
    },
    'docker-compose' => {
      'config' => {
        # Version 2 docker-compose format
        'version' => '2',
        'services' => {
          'gitlab' => {
            'restart' => 'always',
            'image' => 'gitlab/gitlab-ce:latest',
            'hostname' => gitlab_cn,
            'ports' => [
              "#{gitlab_https_port}:#{gitlab_https_port}",
              "#{gitlab_registry_port}:#{gitlab_registry_port}",
              "#{gitlab_ssh_port}:22",
            ],
            'environment' => {
            },
            #'volumes' => [
            #],
          },
        },
      },
    },
  },
)
```

- `roles/gitlab-runner.rb`

```ruby
name 'gitlab-runner'
description 'GitLab-runner'

run_list(
  #'recipe[ssl_cert::ca_certs]',  # gitlab-grid cookbook < 0.1.4
  'role[docker]',
  'recipe[gitlab-grid::runner-docker-compose]',
)

#env_run_lists()

#default_attributes()

ca_name = 'grid_ca'  # Internal CA

override_attributes(
  'ssl_cert' => {
    #'ca_names' => [
    #  ca_name,  # gitlab-grid cookbook < 0.1.6
    #],
  },
  'gitlab-grid' => {
    #'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'ca_name' => ca_name,
    },
    'runner-docker-compose' => {
      #'import_ca' => true,
      'config' => {
        'services' => {
          'runner' => {
            'volumes' => [
              # for Docker executor
              '/var/run/docker.sock:/var/run/docker.sock',
            ],
          },
        },
      },
    },
  },
)
```

### Internal CA certificates management by ssl_cert cookbook

See https://supermarket.chef.io/cookbooks/ssl_cert

### SSL server keys and certificates management by ssl_cert cookbook

- create vault items.

```text
$ ruby -rjson -e 'puts JSON.generate({"private" => File.read("gitlab.io.example.com.prod.key")})' \
> > ~/tmp/gitlab.io.example.com.prod.key.json

$ ruby -rjson -e 'puts JSON.generate({"public" => File.read("gitlab.io.example.com.prod.crt")})' \
> > ~/tmp/gitlab.io.example.com.prod.crt.json

$ cd $CHEF_REPO_PATH

$ knife vault create ssl_server_keys gitlab.io.example.com.prod \
> --json ~/tmp/gitlab.io.example.com.prod.key.json

$ knife vault create ssl_server_certs gitlab.io.example.com.prod \
> --json ~/tmp/gitlab.io.example.com.prod.crt.json
```

- grant reference permission to the gitlab host

```text
$ knife vault update ssl_server_keys  gitlab.io.example.com.prod -S 'name:gitlab*.io.example.com'
$ knife vault update ssl_server_certs gitlab.io.example.com.prod -S 'name:gitlab*.io.example.com'
```

- modify run_list and attributes

```ruby
run_list(
  #'recipe[ssl_cert::server_key_pairs]',  # gitlab-grid <= 0.1.3
  'recipe[gitlab-grid::server]',
  #'recipe[gitlab-grid::docker-compose]',
)

override_attributes(
  'ssl_cert' => {
    'common_names' => [
      'gitlab.io.example.com',
    ],
  },
  'gitlab-grid' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => 'gitlab.io.example.com',
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
