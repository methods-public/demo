nexus-grid Cookbook
===================

This cookbook sets up a Sonatype Nexus Repository Manager by Docker Compose.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
    - [cookbooks](#cookbooks)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [nexus-grid::default](#nexus-griddefault)
        - [nexus-grid::docker-compose](#nexus-griddocker-compose)
    - [Role Examples](#role-examples)
    - [SSL server keys and certificates management by ssl_cert cookbook](#ssl-server-keys-and-certificates-management-by-ssl_cert-cookbook)
- [License and Authors](#license-and-authors)

## Requirements

### platforms
- RHEL, CentOS >= 7.0
- Debian >= 8.0
- Ubuntu >= 14.04

### packages
- none.

### cookbooks
- `docker-grid`
- `platform_utils`
- `ssl_cert`

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['nexus-grid']['with_ssl_cert_cookbook']`|Boolean|Activates TLS configurations by the `ssl_cert` cookbook. See `attributes/default.rb`|`false`|
|`['nexus-grid']['ssl_cert']['common_name']`|String|Server common name for TLS|`node['fqdn']`|
|`['nexus-grid']['docker-compose']['app_dir']`|String||`"#{node['docker-grid']['compose']['app_dir']}/nexus"`|
|`['nexus-grid']['docker-compose']['etc_dir']`|String||`"#{node['nexus-grid']['docker-compose']['app_dir']}/etc"`|
|`['nexus-grid']['docker-compose']['data_dir']`|String|Path string or nil (unset).|`"#{node['nexus-grid']['docker-compose']['app_dir']}/data"`|
|`['nexus-grid']['docker-compose']['config']`|Hash|`docker-compose.yml` configurations.|See `attributes/default.rb`|

## Usage

### Recipes

#### nexus-grid::default

This recipe does nothing.

#### nexus-grid::docker-compose

This recipe generates a `docker-compose.yml` file for the Sonatype Nexus Repository Manager service.

### Role Examples

- `roles/nexus.rb`

```ruby
name 'nexus'
description 'Nexus'

run_list(
  'role[docker]',
  'recipe[nexus-grid::docker-compose]',
)

image = 'sonatype/nexus3'
#image = 'sonatype/nexus'  # Nexus2
port = '8081'

override_attributes(
  'nexus-grid' => {
    'docker-compose' => {
      'config' => {
        'version' => '2',
        'services' => {
          'reverseproxy' => {
            'ports' => [
              "#{port}:8081",
            ],
            'volumes' => [
              # This volume will be set by the nexus-grid::docker-compose recipe automatically.
              #"#{node['nexus-grid']['docker-compose']['etc_dir']}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro",
            ],
          },
          'nexus' => {
            'restart' => 'always',
            'image' => image,
            'volumes' => [
              # This volume will be set by the nexus-grid::docker-compose recipe automatically.
              # * Nexus3
              #"#{node['nexus-grid']['docker-compose']['data_dir']}:/nexus-data:rw",
              # * Nexus2
              #"#{node['nexus-grid']['docker-compose']['data_dir']}:/sonatype-work:rw",
            ],
            'environment' => {
              # * Nexus3
              #'JAVA_MAX_HEAP' => '1200m',  # passed as -Xmx. Defaults to 1200m.
              #'JAVA_MIN_HEAP' => '1200m',  # passed as -Xms. Defaults to 1200m.
              #'EXTRA_JAVA_OPTS' => '',  # Additional options can be passed to the JVM via this variable.
              # * Nexus2
              #'CONTEXT_PATH' => '/nexus',
              #'MAX_HEAP' => '768m',
              #'MIN_HEAP' => '256m',
              #'JAVA_OPTS' => '-server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true',
              #'LAUNCHER_CONF' => './conf/jetty.xml ./conf/jetty-requestlog.xml',
            },
          },
        },
      },
    },
  },
)
```

- `roles/nexus-with-ssl.rb`

```ruby
name 'nexus-with-ssl'
description 'Nexus with SSL by reverse proxy (nginx)'

run_list(
  #'recipe[ssl_cert::server_key_pairs]',  # nexus-grid cookbook < 0.1.3
  'role[docker]',
  'recipe[nexus-grid::docker-compose]',
)

image = 'sonatype/nexus3'
#image = 'sonatype/nexus'  # Nexus2
port = '8081'
cn = 'nexus.io.example.com'

override_attributes(
  'ssl_cert' => {
    #'common_names' => [
    #  cn,  # nexus-grid cookbook < 0.1.4
    #],
  },
  'nexus-grid' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => cn,
    },
    'docker-compose' => {
      'config' => {
        'version' => '2',
        'services' => {
          'reverseproxy' => {
            'ports' => [
              "#{port}:8081",
            ],
            'volumes' => [
              # These volumes will be set by the nexus-grid::docker-compose recipe automatically.
              #"#{node['nexus-grid']['docker-compose']['etc_dir']}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro",
              # and server key pair volume conf.
            ],
          },
          'nexus' => {
            'restart' => 'always',
            'image' => image,
            'volumes' => [
              # This volume will be set by the nexus-grid::docker-compose recipe automatically.
              # * Nexus3
              #"#{node['nexus-grid']['docker-compose']['data_dir']}:/nexus-data:rw",
              # * Nexus2
              #"#{node['nexus-grid']['docker-compose']['data_dir']}:/sonatype-work:rw",
            ],
            'environment' => {
              # * Nexus3
              #'JAVA_MAX_HEAP' => '1200m',  # passed as -Xmx. Defaults to 1200m.
              #'JAVA_MIN_HEAP' => '1200m',  # passed as -Xms. Defaults to 1200m.
              #'EXTRA_JAVA_OPTS' => '',  # Additional options can be passed to the JVM via this variable.
              # * Nexus2
              #'CONTEXT_PATH' => '/nexus',
              #'MAX_HEAP' => '768m',
              #'MIN_HEAP' => '256m',
              #'JAVA_OPTS' => '-server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true',
              #'LAUNCHER_CONF' => './conf/jetty.xml ./conf/jetty-requestlog.xml',
            },
          },
        },
      },
    },
  },
)
```

### SSL server keys and certificates management by the `ssl_cert` cookbook

- create vault items.

```text
$ ruby -rjson -e 'puts JSON.generate({"private" => File.read("nexus.io.example.com.prod.key")})' \
> > ~/tmp/nexus.io.example.com.prod.key.json

$ ruby -rjson -e 'puts JSON.generate({"public" => File.read("nexus.io.example.com.prod.crt")})' \
> > ~/tmp/nexus.io.example.com.prod.crt.json

$ cd $CHEF_REPO_PATH

$ knife vault create ssl_server_keys nexus.io.example.com.prod \
> --json ~/tmp/nexus.io.example.com.prod.key.json

$ knife vault create ssl_server_certs nexus.io.example.com.prod \
> --json ~/tmp/nexus.io.example.com.prod.crt.json
```

- grant reference permission to the Concourse host

```text
$ knife vault update ssl_server_keys  nexus.io.example.com.prod -S 'name:nexus-host.example.com'
$ knife vault update ssl_server_certs nexus.io.example.com.prod -S 'name:nexus-host.example.com'
```

- modify run_list and attributes

```ruby
run_list(
  #'recipe[ssl_cert::server_key_pairs]',  # nexus-grid cookbook < 0.1.3
  'recipe[nexus-grid::docker-compose]',
)

override_attributes(
  'ssl_cert' => {
    #'common_names' => [
    #  'nexus.io.example.com',  # nexus-grid cookbook < 0.1.4
    #],
  },
  'nexus-grid' => {
    'with_ssl_cert_cookbook' => true,
    'ssl_cert' => {
      'common_name' => 'nexus.io.example.com',
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
