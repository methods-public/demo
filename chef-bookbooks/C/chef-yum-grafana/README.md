# yum-grafana Cookbook

The yum-grafana cookbook manages the yum repofile for the grafana repository.

## Requirements

### Platforms

- RHEL/CentOS and derivatives

### Chef

- Chef 12.5+

### Cookbooks

- yum version 3.2.0 or higher

## Attributes

The following attributes are set by default

```ruby
default['yum']['grafana']['repositoryid'] = 'grafana'
default['yum']['grafana']['gpgkey'] = 'https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana'
default['yum']['grafana']['description'] = 'Grafana RPM Repository'
default['yum']['grafana']['failovermethod'] = 'priority'
default['yum']['grafana']['gpgcheck'] = true
default['yum']['grafana']['enabled'] = true
default['yum']['grafana']['base_url'] = 'https://packagecloud.io/grafana/stable/el/6/$basearch'
```

## Recipes

- default - Installs the Grafana RPM repository, eg:

```ruby
  yum_repository 'grafana' do
    base_url 'https://packagecloud.io/grafana/stable/el/6/$basearch'
    description 'Grafana RPM Repository'
    enabled true
    gpgcheck true
  end
```

## Usage Example

To disable the Grafana repository through a Role or Environment definition

```
default_attributes(
  :yum => {
    :grafana => {
      :enabled => {
        false
       }
     }
   }
 )
```

## More Examples

Point the grafana repository at an internally hosted server.

```
node.default['yum']['grafana']['enabled'] = true
node.default['yum']['grafana']['mirrorlist'] = nil
node.default['yum']['grafana']['baseurl'] = 'https://internal.example.com/rpm/grafana/'
node.default['yum']['grafana']['sslverify'] = false

include_recipe 'yum-grafana'
```

License and Author
==================

- Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)

Copyright 2017, Movile

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
