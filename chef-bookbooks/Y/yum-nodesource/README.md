# yum-nodesource Cookbook

iThe yum-nodesource cookbook takes over management of the default repository
ids shipped with nodesource-release. It allows attribute manipulation of 
`nodesource_4x`, `nodesource_5x` and `nodesource_6x`.

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
default['yum']['nodesource_4x']['repositoryid'] = 'nodesource_4x'
default['yum']['nodesource_4x']['gpgkey'] = 'https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL'
default['yum']['nodesource_4x']['description'] = 'Nodesource NodeJS 4.x RPM Repository'
default['yum']['nodesource_4x']['failovermethod'] = 'priority'
default['yum']['nodesource_4x']['gpgcheck'] = true
default['yum']['nodesource_4x']['enabled'] = true
default['yum']['nodesource_4x']['base_url'] = 'https://rpm.nodesource.com/pub_4.x/el/6/x86_64/'
```

```ruby
default['yum']['nodesource_5x']['repositoryid'] = 'nodesource_5x'
default['yum']['nodesource_5x']['gpgkey'] = 'https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL'
default['yum']['nodesource_5x']['description'] = 'Nodesource NodeJS 5.x RPM Repository'
default['yum']['nodesource_5x']['failovermethod'] = 'priority'
default['yum']['nodesource_5x']['gpgcheck'] = true
default['yum']['nodesource_5x']['enabled'] = true
default['yum']['nodesource_5x']['base_url'] = 'https://rpm.nodesource.com/pub_5.x/el/6/x86_64/'
```

```ruby
default['yum']['nodesource_5x']['repositoryid'] = 'nodesource_6x'
default['yum']['nodesource_5x']['gpgkey'] = 'https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL'
default['yum']['nodesource_5x']['description'] = 'Nodesource NodeJS 6.x RPM Repository'
default['yum']['nodesource_5x']['failovermethod'] = 'priority'
default['yum']['nodesource_5x']['gpgcheck'] = true
default['yum']['nodesource_5x']['enabled'] = true
default['yum']['nodesource_5x']['base_url'] = 'https://rpm.nodesource.com/pub_6.x/el/6/x86_64/'
```

## Recipes

- default - Uses the 4x repository

- 4x - Installs the NodeJS 4x repository, eg:

```ruby
  yum_repository 'nodesource_4x' do
    base_url 'https://rpm.nodesource.com/pub_4.x/el/6/x86_64/'
    description 'Nodesource NodeJS 4.x RPM Repository'
    enabled true
    gpgcheck true
  end
```

- 5x - Installs the NodeJS 5x repository, eg:

```ruby
  yum_repository 'nodesource_5x' do
    base_url 'https://rpm.nodesource.com/pub_5.x/el/6/x86_64/'
    description 'Nodesource NodeJS 5.x RPM Repository'
    enabled true
    gpgcheck true
  end
```

- 6x - Installs the NodeJS 6x repository, eg:

```ruby
  yum_repository 'nodesource_6x' do
    base_url 'https://rpm.nodesource.com/pub_6.x/el/6/x86_64/'
    description 'Nodesource NodeJS 6.x RPM Repository'
    enabled true
    gpgcheck true
  end
```

## Usage Example

To disable the nodesource 4x repository through a Role or Environment definition

```
default_attributes(
  :yum => {
    :nodesource_4x => {
      :enabled => {
        false
       }
     }
   }
 )
```

## More Examples

Point the nodesource\_4x repositories at an internally hosted server.

```
node.default['yum']['nodesource_4x']['enabled'] = true
node.default['yum']['nodesource_4x']['mirrorlist'] = nil
node.default['yum']['nodesource_4x']['baseurl'] = 'https://internal.example.com/rpm/nodesource_4x/'
node.default['yum']['nodesource_4x']['sslverify'] = false

include_recipe 'yum-nodesource::4x'

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
